Invoice = require './invoice'
Observer = require '../observer'
ee = require '../events'
validation = require('../validation').client

class Client

  constructor : ->
    
    @data =
      type                : 'Client'
      _rev                : ko.observable()
      _id                 : ko.observable()
      identifier          : ko.observable()
      name                : ko.observable()
      registration_number : ko.observable()
      email               : ko.observable()
      bank                : ko.observable()
      street_number       : ko.observable()
      zipcode             : ko.observable()
      place               : ko.observable()

    @d = @data
    @validation = validation @data
    @invoices = ko.observableArray()
    @selected = ko.observable false
    @fullname = ko.dependentObservable => @data.identifier() + ' ' + @data.name()

    ee.on 'client-select', => @selected false
    ee.on 'invoices-remove', @invoiceRemove

    @observer = new Observer @data, @save, ['_rev', '_id']


  createInvoice : =>

    invoice = new Invoice
    invoice.data.clientId this.data._id()
    @invoices.unshift invoice
    ee.emit 'invoices-new', invoice


  save : =>

    ee.emit 'clients-save', this


  remove : =>

    @deselect()
    ee.emit 'client-deselect', this
    ee.emit 'clients-remove' , this


  select : ->

    ee.emit 'client-select'   , this
    ee.emit 'client-invoices' , this
    @selected true


  deselect : ->

    @selected false

  
  invoiceRemove : (invoice)=>

    @invoices.remove invoice


module.exports = Client
