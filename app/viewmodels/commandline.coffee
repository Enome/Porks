ee = require '../events'

class CommandLine

  constructor : ->

    @command = ko.observable()
    @command.subscribe (val)->
      ee.emit 'command-clients-new', val if val


module.exports = CommandLine
