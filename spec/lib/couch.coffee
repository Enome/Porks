testClients = require('../fakedata').clients
testSettings = require('../fakedata').settings
testInvoices = require('../fakedata').invoices

module.exports = (name)->

  database : name
  
  view : (view, options)->

    if view is 'Porks/allSettings'

      options.success rows : [ value : testSettings() ]


    if view is 'Porks/allClients'

      if options.keys
        options.success rows: [ {value: testClients()[0]} ]
      else
        options.success rows : {value: client} for client in testClients()


    if view is 'Porks/allInvoices'

      if options.keys
        options.success rows: [ {value: testInvoices()[0]} ]
      else
        options.success rows : {value: invoice} for invoice in testInvoices()


  saveDoc : (data, options)->

    options.success
      id : 1
      rev : 'rev-1'


  removeDoc  : ->
  bulkRemove : ->

  openDoc : (_, options)->

    if _ is 'someinvoice'
      options.success testInvoices()[0]

    if _ is 'someclient'
      options.success testClients()[0]
