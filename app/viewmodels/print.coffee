couch = require '../libs/couch'
Invoice = require '../../app/viewmodels/invoice'
Settings = require '../../app/viewmodels/settings'
Client = require '../../app/viewmodels/client'
ee = require '../../app/events'


class Print

  constructor : ->

    @hash = window.location.hash.replace '#', ''

    @invoice = new Invoice
    ee.emit 'invoices-get', @invoice, @hash

    @settings = new Settings
    ee.emit 'settings-get', @settings

    @itsme = new Client
    ee.emit 'clients-itsme', '0', @itsme

    @you = new Client

    @invoice.data.clientId.subscribe (id)=>

      ee.emit 'clients-get', @you, id


module.exports = Print
