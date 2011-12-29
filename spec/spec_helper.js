require('jessie').sugar();
require('coffee-script');
$ = require('jquery');
global.window = require('jsdom').jsdom().createWindow();
global.window.$ = $;
global.navigator = {};

fake_couch = require('./lib/couch');
couch = require('../app/libs/couch');
require('../app/libs/date')

couch.db = fake_couch;

global.ko = require('../app/libs/ko');

global.kk = {}
require('../app/libs/kk');
