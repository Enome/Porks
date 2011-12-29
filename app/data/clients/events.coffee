ee = require '../../events'
Repo = require './repo'
InvoicesRepo = require '../invoices/repo'
Settings = require '../settings/repo'
Client = require '../../viewmodels/client'
InvoiceMap = require '../invoices/map'
ClientMap = require './map'
Invoice = require '../../viewmodels/invoice'


class Events


  constructor : ->

    ee.on 'clients-new'     , @setDefaults
    ee.on 'clients-remove'  , @remove
    ee.on 'clients-save'    , @save
    ee.on 'data-clients-all', @all
    ee.on 'client-invoices' , @clientInvoices
    ee.on 'clients-itsme'   , @getByIdentifier
    ee.on 'clients-get'     , @get

    @repo = new Repo


  setDefaults : (client)->

    settingsRepo = new Settings
    settingsRepo.clientCounter (counter)-> client.data.identifier counter


  all : (clients)=>

    @repo.all (data)->


      clientMap = new ClientMap
      clients( clientMap.map( d, new Client ) for d in data )

      clients.sort (left, right)->
        parseInt(left.data.identifier()) - parseInt(right.data.identifier())

      clients.reverse()


  remove : (client)=>

    @repo.removeModel client.data


  save : (client)=>

    @repo.saveModel client.data


  clientInvoices : (client)=>

    invoices = new InvoicesRepo
    mapInvoice = new InvoiceMap

    invoices.clientInvoices client, (data)=>

      client.invoices( mapInvoice.map( d, new Invoice ) for d in data )

      client.invoices.sort (left, right)->
        left.data.identifier() + right.data.identifier()


  getByIdentifier : (key, client)=>

    @repo.getByKey [ key ], (data)->

      if data.rows.length
        clientMap = new ClientMap
        clientMap.map data.rows[0].value, client
  

  get : (client, id)=>

    @repo.get id, (data)->

        clientMap = new ClientMap
        clientMap.map data, client


module.exports = Events
