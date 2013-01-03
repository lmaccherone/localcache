class LocalCache

  @meta = null
  @localStorage = null

  constructor: (@directoryForNodeJSCache = './local-storage-cache', @keyForMetaData = 'local-storage-cache-key-for-meta-data') ->
    ###
    @constructor
    @param {String} [directoryForNodeJSCache] This is not used if running in the browser
    @param {String} [keyForMetaData]
    ###
    # Note: Storing in the class itself for singleton behavior
    if localStorage?
      LocalCache.localStorage = localStorage
    else  # Assume in node.js
      LocalStorage = require('node-localstorage').LocalStorage
      LocalCache.localStorage = new LocalStorage(@directoryForNodeJSCache)

    unless LocalCache.meta?
      LocalCache.meta = @getItem(@keyForMetaData)
      unless LocalCache.meta?
        LocalCache.meta = {}  # {key: {lastUpdated: <Date().getTime() of last time updated>}}

  setItem: (key, value) ->
    ###
    @method setItem
      Stores the value in the cache under the provided key. If the storing of the value will not fit in the cache size
      it will delete the Least Recently Updated item in the cache to make room for this one. Uses JSON.stringify to
      put the value into a string form for storage. This may not work great for all types so make sure your value is
      an Object and not a bare String or other type.
    @param {String} key
    @param {Object} value
    ###
    # first update the key itself
    while true
      try
        LocalCache.localStorage.setItem(key, JSON.stringify(value))
        break  # breaks out of the while loop
      catch e
        if e.name == 'QUOTA_EXCEEDED_ERR'
          # Deleted least recently updated
          oldestTime = new Date().getTime()
          oldestKey = null
          for mkey, mvalue of LocalCache.meta
            if mvalue.lastUpdated < oldestTime
              oldestKey = mkey
              oldestTime = mvalue.lastUpdated
          @removeItem(oldestKey)
        else
          throw e

    # Now update the meta item
    metaRow = {}
    metaRow.lastUpdated = new Date().getTime()
    LocalCache.meta[key] = metaRow
    while true
      try
        LocalCache.localStorage.setItem(@keyForMetaData, JSON.stringify(LocalCache.meta))
        break  # breaks out of the while loop
      catch e
        if e.name == 'QUOTA_EXCEEDED_ERR'
          # Deleted least recently updated
          oldestTime = new Date().getTime()
          oldestKey = null
          for mkey, mvalue of LocalCache.meta
            if mvalue.lastUpdated < oldestTime
              oldestKey = mkey
              oldestTime = mvalue.lastUpdated
          @removeItem(oldestKey)
        else
          throw e

    return this

  getItem: (key) ->
    ###
    @method getItem
      Returns the value at the provided key. Uses JSON.parse to get it back into Object form before returning.
    @param {String} key
    ###
    value = LocalCache.localStorage.getItem(key)
    if value?
      return JSON.parse(value)
    else
      return undefined

  removeItem: (key) ->
    ###
    @method removeItem
      Removes the item from the cache.
    @param {String} key
    ###
    LocalCache.localStorage.removeItem(key)
    delete(LocalCache.meta[key])
    LocalCache.localStorage.setItem(@keyForMetaData, JSON.stringify(LocalCache.meta))
    return this

  clear: () ->
    ###
    @method clear
      Deletes all members of the cache according to the meta value. Will not empty the entire localStorage if they were
      inserted by another cache or other code using localStorage. Clear the browser cache to remove all of those.
    ###
    for key, metaRow of LocalCache.meta
      LocalCache.localStorage.removeItem(key)
    LocalCache.meta = {}
    LocalCache.localStorage.setItem(@keyForMetaData, JSON.stringify(LocalCache.meta))
    return this

if typeof exports != 'undefined' and this.exports != exports
  exports.LocalCache = LocalCache
else
  this.LocalCache = LocalCache
