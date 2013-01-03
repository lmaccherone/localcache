{LocalCache} = require('../')

exports.LocalCacheTest =

  testLocalCache: (test) ->
    localCache = new LocalCache('./scratch')

    localCache.setItem('1', 'something')
    test.equal(localCache.getItem('1'), 'something')
    
    o = {a:1, b:'some string', c:{x: 1, y: 2}}
    localCache.setItem('2', o)
    test.deepEqual(localCache.getItem('2'), o)

    a = [1, 'some string', {a:1, b:'some string', c:{x: 1, y: 2}}]
    localCache.setItem('2', a)
    test.deepEqual(localCache.getItem('2'), a)

    localCache.removeItem('2')
    test.equal(localCache.getItem('2'), undefined)
    
    localCache.clear()
    map = localCache.meta
    count = 0
    for m, value of map
      count++
    test.equal(count, 0)
       
    LocalCache.localStorage._deleteLocation()

    test.done()