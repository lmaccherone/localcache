[![build status](https://secure.travis-ci.org/lmaccherone/node-localstorage.png)](http://travis-ci.org/lmaccherone/node-localstorage)
# node-localstorage #

Copyright (c) 2012, Lawrence S. Maccherone, Jr.

_A drop-in substitute for the browser native localStorage API that runs on node.js._

### Working ###

* All methods in the [localStorage spec](http://www.w3.org/TR/webstorage/#storage) 
  interface including:
  * length
  * setItem(key, value)
  * getItem(key)
  * removeItem(key)
  * key(n)
  * clear()  
* Serializes to disk in the location specified during instantiation

### Unsupported ###

* Events
* Associative array syntax `localStorage['myKey'] = 'myValue'`

## Credits ##

Author: [Larry Maccherone](http://maccherone.com)

## Usage ##

### CoffeeScript ###

    unless localStorage?
      {LocalStorage} = require('../')  # require('node-localstorage') for you
      localStorage = new LocalStorage('./scratch')

    localStorage.setItem('myFirstKey', 'myFirstValue')
    console.log(localStorage.getItem('myFirstKey'))
    # myFirstValue
    
    localStorage._deleteLocation()  # cleans up ./scratch created during doctest

### JavaScript ###

```JavaScript    
if (typeof localStorage === "undefined" || localStorage === null) {
  var LocalStorage = require('node-localstorage').LocalStorage;
  localStorage = new LocalStorage('./scratch');
}

localStorage.setItem('myFirstKey', 'myFirstValue');
console.log(localStorage.getItem('myFirstKey'));
```

## Installation ##

`npm install node-localstorage`

## Changelog ##

* 0.1.0 - 2012-10-29 - Original version
* 0.1.1 - 2012-10-29 - Update to support Travis CI
* 0.1.2 - 2012-11-02 - Finally got Travis CI working

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