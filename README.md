[![build status](https://secure.travis-ci.org/lmaccherone/localcache.png)](http://travis-ci.org/lmaccherone/localcache)
# localcache #

Copyright (c) 2013, Lawrence S. Maccherone, Jr.

_Uses localStorage (or node-localstorage) to implement a Least Recently Updated cache_

## Features ##
* Uses localStorage when running in the browser
* Uses node-localstorage when running in node.js
* Allows you to set the quota when running in node.js
* Implements Least Recently Updated algorithm which is ideal for incremental chart updates among other use cases

## Credits ##

Author: [Larry Maccherone](http://maccherone.com)

## Usage ##

### CoffeeScript ###

    {LocalCache} = require('../')
    localCache = new LocalCache()

    localCache.setItem('myFirstKey', {key: "value", anotherkey: "another value"})
    console.log(localCache.getItem('myFirstKey').key)
    # value
    
    LocalCache.localStorage._deleteLocation()  # cleans up scratch directory created during doctest

### JavaScript ###

```JavaScript   
var LocalCache = require('../').LocalCache;
var localCache = new LocalCache();

localCache.setItem('myFirstKey', {key: "value", anotherkey: "another value"});

console.log(localCache.getItem('myFirstKey').key);
// value

LocalCache.localStorage._deleteLocation();
```

## Installation ##

`npm install localcache --save`

## Changelog ##

* 0.1.0 - 2013-01-03 - Original version

## MIT License ##

Copyright (c) 2011, 2012, Lawrence S. Maccherone, Jr.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and 
to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
IN THE SOFTWARE.