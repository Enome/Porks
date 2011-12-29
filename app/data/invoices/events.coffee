ee = require '../../events'
Repo = require './repo'
MapInvoice = require './map'
SettingsRepo = require '../settings/repo'


class Events

  constructor : ->

    @repo = new Repo

    ee.on 'clients-remove' , @repo.removeClientInvoices
    ee.on 'invoices-new'   , @setDefaults
    ee.on 'invoices-save'  , @save
    ee.on 'invoices-remove', @remove
    ee.on 'invoices-get'   , @get


  setDefaults : (invoice)=>

    settingsRepo = new SettingsRepo

    settingsRepo.invoiceCounter (counter)=>

      invoice.data.identifier counter

      settingsRepo.settings (data)=>

        invoice.data.disclaimer data.disclaimer
        invoice.data.expiration data.expiration
        invoice.data.tax data.tax
        invoice.select()
        ee.emit 'invoices-save', invoice

  
  save : (invoice)=>

    @repo.saveModel invoice.data, @adjustParts


  adjustParts : (js)->

    for part in js.parts
      delete part.data.__ko_mapping__

    js.parts = ( part.data for part in js.parts )

  
  remove : (invoice)=>

    @repo.removeModel invoice.data

  
  get : (invoice, id)=>

    mapInvoice = new MapInvoice
    @repo.get id, (data)-> mapInvoice.map data, invoice


module.exports = Events
