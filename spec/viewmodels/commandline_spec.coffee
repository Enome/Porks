ee = require '../../app/events'
CommandLine = require '../../app/viewmodels/commandline'


describe 'CommandLine', ->


  beforeEach ->

    spyOn ee, 'emit'


  describe 'Non defined command', ->
    
    it 'should emit command-clients-new', ->

        cl = new CommandLine()
        cl.command 'somevalue'
        ee.emit.should_have_been_called_with 'command-clients-new', 'somevalue'


    it 'should not emit if value is empty', ->

        cl = new CommandLine()
        cl.command ''
        ee.emit.should_have_not_been_called()
