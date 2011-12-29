ee = require '../events'
validation = require('../validation').settings
Observer =  require '../observer'

class Settings


  constructor : ->

    @data =
      type : 'Settings'
      _id : ko.observable()
      _rev : ko.observable()
      clientCounter : ko.numericObservable()
      invoiceCounter : ko.numericObservable()
      disclaimer : ko.observable()
      expiration : ko.numericObservable()
      tax : ko.numericObservable()
      currency: ko.observable()

    @d = @data
    @selected = ko.observable(false)
    @validation = validation @data

    @observer = new Observer @data, @update, ['_id', '_rev']


  update : =>

    ee.emit 'settings-update', this


  getClientCounter : ->

    @data.clientCounter.add 1
    @data.clientCounter()


  getInvoiceCounter : ->

    @data.invoiceCounter.add 1
    @data.invoiceCounter()


  select : =>

    @observer.stop()
    @selected true
    ee.emit 'settings-select', this


module.exports = Settings
