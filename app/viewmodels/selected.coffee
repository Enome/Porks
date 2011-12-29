ee = require '../events'

class Selected

  constructor : ->

    @client = ko.observable()
    @invoice = ko.observable()
    @settings = ko.observable()

    ee.on 'client-select'     , @setClient
    ee.on 'invoice-select'    , @setInvoice
    ee.on 'settings-select'   , @setSettings
    ee.on 'client-deselect'   , @clearAll
    ee.on 'invoices-deselect' , @clearAll
    

  setClient : (client)=>

    client.validation.validate()
    @clearAll()
    @client client
    client.observer.start()


  setInvoice : (invoice)=>

    invoice.validation.validate()
    @clearAll()
    @invoice invoice
    invoice.observer.start()


  setSettings : (settings)=>
    
    settings.validation.validate()
    @clearAll()
    @settings settings


  clearAll : =>

    @client null
    @invoice null
    @settings null


module.exports = Selected
