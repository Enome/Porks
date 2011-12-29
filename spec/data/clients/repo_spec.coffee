Subject = require '../../../app/data/clients/repo'
clientsData = require('../../fakedata').clients


describe 'Client Repo ->', ->


  describe 'all ->', ->


    it 'should call the callback', ->

      cb = jasmine.createSpy()
      clients = new Subject
      clients.all cb
      cb.should_have_been_called()


    it 'should get 3 clients' , ->

      clients = new Subject
      clients.all (clients)->
        clients.length.should_be 3


    it 'should get the clients from the fake database', ->

      clients = new Subject
      clients.all (clients)->
        
        for client, i in clients
          expect(client).toEqual clientsData()[i]


  describe 'saveModel ->', ->


    viewmodel = null

    beforeEach ->

      viewmodel =
        _rev : ko.observable()
        _id : ko.observable()


    it 'should convert the observables into javascript', ->

      spyOn ko, 'toJS'
      clients = new Subject
      clients.saveModel viewmodel
      ko.toJS.should_have_been_called_with viewmodel


    it 'should saveModel the js object', ->

      spyOn ko, 'toJS'
      clients = new Subject
      spyOn clients.db, 'saveDoc'
      clients.saveModel viewmodel
      clients.db.saveDoc.should_have_been_called_with  \
      ko.toJS(), jasmine.any(Object)


    it 'should set the _rev of the viewmodel', ->

      clients = new Subject
      clients.saveModel viewmodel
      viewmodel._rev().should_be 'rev-1'


    it 'should set the _id of the viewmodel', ->

      clients = new Subject
      clients.saveModel viewmodel
      viewmodel._id().should_be 1


    it 'should remove the mapping options', ->

      viewmodel.__ko_mapping__ = 'mapping options'
      clients = new Subject
      spyOn clients, 'save'
      clients.saveModel viewmodel
      expect(clients.save.mostRecentCall.args[0].__ko_mapping__).toBeUndefined()
