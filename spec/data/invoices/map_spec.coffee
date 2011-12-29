fakeInvoices = require('../../fakedata').invoices
Subject = require '../../../app/data/invoices/map'
Invoice = require '../../../app/viewmodels/invoice'
Part = require '../../../app/viewmodels/part'


describe 'Map Invoices and their parts ->', ->


  subject = null


  beforeEach ->

    subject = new Subject


  describe 'map ->', ->


    invoiceData = invoice = null

    beforeEach ->

      invoiceData = fakeInvoices()[0]
      invoice = subject.map invoiceData, new Invoice


    it 'should map the data to the invoice data', ->

      expected = ko.toJS invoice.data
      delete expected.__ko_mapping__
      delete expected.parts
      delete invoiceData.parts
      expect( expected ).toEqual invoiceData


    it 'should map the parts as viewmodels', ->

      for part in invoice.data.parts()
        expect( part instanceof Part ).toBeTruthy()


    it 'should have 3 parts', ->

      invoice.data.parts().length.should_be 3


  describe 'mapPart ->', ->


    invoiceData = partData = part = null

    beforeEach ->

      invoiceData = fakeInvoices()[0]
      partData = invoiceData.parts[0]
      part = subject.mapPart partData


    it 'should map the data to part data', ->

      expected = ko.toJS part.data
      delete expected.__ko_mapping__
      expect( partData ).toEqual expected


    it 'should have 15.00 as the cost of the first part', ->

      part.data.cost().should_be "15.00"


    it 'should have description text as the description of the first part', ->

      part.data.description().should_be "This is a description"
