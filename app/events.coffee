EventEmitter = require('events').EventEmitter
ee = new EventEmitter
ee.setMaxListeners 0
module.exports = ee
