ee = require '../../app/events'
Clients = require '../../app/viewmodels/clients'
Client = require '../../app/viewmodels/client'

describe 'Clients', ->


  subject = null

  beforeEach ->
    spyOn ee, 'on'
    spyOn ee, 'emit'
    subject = new Clients


  describe 'constructor ->', ->


    it 'should listen to command-all', ->

      ee.on.should_have_been_called_with \
      'command-clients-new', subject.newClient


    it 'should tell the database to populate clients list', ->

      ee.emit.should_have_been_called_with \
      'data-clients-all', subject.clients


    it 'should listen to clients-remove', ->

      ee.on.should_have_been_called_with 'clients-remove', subject.removeClient


  describe 'newClient ->', ->


    it 'should set the name of the client to foo', ->

      subject.newClient 'Foo'
      subject.clients()[0].data.name().should_be 'Foo'


    it 'should add a client to clients', ->

      subject.newClient 'Foo'
      subject.clients().length.should_be 1


    it 'should tell the that a new client was created', ->

      subject.newClient 'Foo'
      ee.emit.should_have_been_called_with 'clients-new', subject.clients()[0]


    it 'should select the new client', ->

      spyOn Client.prototype, 'select'
      subject.newClient 'Foo'
      Client.prototype.select.should_have_been_called_with()


  describe 'removeClient ->', ->


   it 'should remove the client', ->

     client = new Client
     subject.clients [ new Client, client, new Client ]
     subject.removeClient client
     subject.clients.indexOf(client).should_be -1
