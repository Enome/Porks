Client = require '../../../app/viewmodels/client'
Invoice = require '../../../app/viewmodels/invoice'
Subject = require '../../../app/data/invoices/repo'

describe 'Repo: Invoice ->', ->

  client = subject = null

  beforeEach ->

    client  = new Client
    subject = new Subject

    client.data._id 'randomid1'


  describe 'clientInvoices ->', ->

    it 'should call the callback', ->

      cb = jasmine.createSpy()
      subject.clientInvoices client, cb
      cb.should_have_been_called()


    it 'should get randomid1 invoices', ->

      subject.clientInvoices client, (invoices)->

        invoices.length.should_be 3


  describe 'removeClientInvoices ->', ->

    
    it 'should call the callback', ->

      spyOn subject, 'bulkRemove'

      callback = jasmine.createSpy()
      subject.clientInvoices client, callback
      callback.should_have_been_called()


    it 'should remove all randomid1 invoices', ->

      spyOn subject, 'bulkRemove'
      subject.removeClientInvoices client, ->

      subject.clientInvoices client, (invoices)->

        subject.bulkRemove.should_have_been_called_with { docs : invoices }, {}
