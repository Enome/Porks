require './libs/ko'
require './libs/kk'
require './libs/date'
require './helpers'


Data        = require './data/init'
Clients     = require './viewmodels/clients'
CommandLine = require './viewmodels/commandline'
Selected    = require './viewmodels/selected'
Settings    = require './viewmodels/settings'
Print       = require './viewmodels/print'


class Porks

  getViewmodel : ->

    cl : new CommandLine
    cs : new Clients
    s  : new Selected
    se : new Settings

  
  getPrintViewmodel : -> p:new Print


module.exports = Porks
