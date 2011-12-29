ee = require '../events'
Client = require './client'


class Clients


  constructor : ->

    @clients = ko.observableArray []

    ee.on 'command-clients-new', @newClient
    ee.on 'clients-remove', @removeClient

    ee.emit 'data-clients-all', @clients


  newClient : (name)=>

    client = new Client
    client.data.name name
    @clients.unshift client
    ee.emit 'clients-new', client
    client.select()


  removeClient : (client)=>

    @clients.remove client


module.exports = Clients
