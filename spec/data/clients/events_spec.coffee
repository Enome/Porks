ee           = require '../../../app/events'
Subject      = require '../../../app/data/clients/events'
Client       = require '../../../app/viewmodels/client'
Invoice      = require '../../../app/viewmodels/invoice'
Clients      = require '../../../app/viewmodels/clients'
Part         = require '../../../app/viewmodels/part'
resetEe      = require '../../lib/ee'
settings     = require('../../fakedata').settings
fakeInvoices = require('../../fakedata').invoices

describe 'Data Events: Clients ->', ->


  subject = null

  beforeEach ->

    resetEe()
    subject = new Subject


  describe 'Constructor ->', ->

    subject = null

    beforeEach ->

      spyOn ee, 'on'
      subject = new Subject


    it 'should listen to clients-new', ->

      ee.on.should_have_been_called_with 'clients-new',  \
      subject.setDefaults


    it 'should listen to data-clients-all', ->

      ee.on.should_have_been_called_with 'data-clients-all', \
      subject.all


    it 'should listen to clients-remove', ->

      ee.on.should_have_been_called_with 'clients-remove', \
      subject.remove


    it 'should listen to clients-save', ->

      ee.on.should_have_been_called_with 'clients-save', \
      subject.save


    it 'should listen to client-invoices', ->

      ee.on.should_have_been_called_with 'client-invoices', \
      subject.clientInvoices


    it 'should listen to clients-itsme', ->

      ee.on.should_have_been_called_with 'clients-itsme', \
      subject.getByIdentifier


    it 'should listen to clients-get', ->

      ee.on.should_have_been_called_with 'clients-get', \
      subject.get


  describe 'SetDefaults ->', ->


    it 'should set the clientCounter', ->

      client = new Client
      ee.emit 'clients-new', client
      client.data.identifier().should_be settings().clientCounter + 1


  describe 'All ->', ->


    it 'should add 3 clients', ->

      clients = new Clients
      subject.all clients.clients
      clients.clients().length.should_be 3


    it 'should have Kaite as the first client', ->

      clients = new Clients
      subject.all clients.clients
      clients.clients()[0].data.name().should_be 'Katie'


  describe 'Remove ->', ->


    it 'should remove the document', ->

      spyOn subject.repo, 'removeModel'
      client = new Client
      ee.emit 'clients-remove', client
      subject.repo.removeModel.should_have_been_called_with client.data


  describe 'save ->', ->


    it 'should save the client', ->

      spyOn subject.repo, 'saveModel'
      client = new Client
      ee.emit 'clients-save', client
      subject.repo.saveModel.should_have_been_called_with client.data


  describe 'Client Invoices ->', ->


    it 'should populate the client\'s invoices', ->

      client = new Client
      client.data._id 'randomid1'
      ee.emit 'client-invoices', client
      client.invoices().length.should_be 3
      

    it 'should be viewmodels and not raw data', ->

      client = new Client
      client.data._id 'randomid1'
      ee.emit 'client-invoices', client
      for invoice in client.invoices()
        expect( invoice instanceof Invoice).toBeTruthy()

    
    it 'should replace and not append to client invoices', ->

      client = new Client
      client.data._id 'randomid1'
      ee.emit 'client-invoices', client
      ee.emit 'client-invoices', client
      client.invoices().length.should_be 3


  describe 'Get by Identifier ->', ->


    it 'should call the repo with the key', ->

      spyOn subject.repo, 'getByKey'
      subject.getByIdentifier 'somekey', {}
      subject.repo.getByKey.should_have_been_called_with \
      ['somekey'], jasmine.any(Function)


    describe 'Properties ->', ->


      client = null


      beforeEach ->

        client = new Client
        subject.getByIdentifier '', client


      testProp = (prop, expect)->

        client.data[prop]().should_be expect


      it 'should all properties', ->
        
        testProp '_id', 'randomid1'
        testProp '_rev', 'rev1'
        testProp 'identifier', '1'
        testProp 'name', 'Benny'
        #...


  describe 'Get ->', ->


    it 'should call the repo with the id', ->

      spyOn subject.repo, 'get'
      subject.get {}, 'someid'

      subject.repo.get.should_have_been_called_with 'someid', jasmine.any(Function)


    describe 'Properties ->', ->


      client = null


      beforeEach ->

        client = new Client
        subject.get client, 'someclient'


      testProp = (prop, expect)->

        client.data[prop]().should_be expect


      it 'should all properties', ->
        
        testProp '_id', 'randomid1'
        testProp '_rev', 'rev1'
        testProp 'identifier', '1'
        testProp 'name', 'Benny'
        #...

