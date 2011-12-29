Repo = require '../../../app/data/settings/repo'
settings = require('../../fakedata').settings


describe 'Settings Repository ->', ->


  repo = null

  beforeEach ->

    repo = new Repo


  describe 'clientCounter', ->


    it 'should call the callback', ->

      callback = jasmine.createSpy()
      repo.clientCounter callback
      callback.should_have_been_called()


    it 'should increment clientCounter to 12', ->
      
      repo.clientCounter (data)-> data.should_be 12


    it 'should save settings', ->

      spyOn repo, 'save'
      repo.clientCounter ->
      sets = settings()
      sets.clientCounter += 1
      repo.save.should_have_been_called_with sets


  describe 'invoiceCounter', ->


    it 'should call the callback', ->

      callback = jasmine.createSpy()
      repo.invoiceCounter callback
      callback.should_have_been_called()


    it 'should increment the invoiceCounter to 12', ->

      repo.invoiceCounter (data)-> data.should_be 16

    
    it 'should save settings', ->

      spyOn repo, 'save'
      repo.invoiceCounter ->
      sets = settings()
      sets.invoiceCounter += 1
      repo.save.should_have_been_called_with sets
