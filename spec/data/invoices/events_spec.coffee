ee = require '../../../app/events'
Subject = require '../../../app/data/invoices/events'
Invoice = require '../../../app/viewmodels/invoice'
resetEe = require '../../lib/ee'

describe 'Events: Invoices ->', ->


  subject = null


  beforeEach ->

    resetEe()
    subject = new Subject


  describe 'Constructor ->', ->

    beforeEach ->

      spyOn ee, 'on'
      subject = new Subject


    it 'should listen to clients-remove', ->

      ee.on.should_have_been_called_with \
      'clients-remove', subject.repo.removeClientInvoices

    
    it 'should listen to invoices-new', ->

      ee.on.should_have_been_called_with \
      'invoices-new', subject.setDefaults


    it 'should listen to invoices-save', ->

      ee.on.should_have_been_called_with \
      'invoices-save', subject.save


    it 'should listen to invoices-get', ->

      ee.on.should_have_been_called_with \
      'invoices-get', subject.get


  describe 'Defaults ->', ->

    it 'should set the identifier', ->

      invoice = new Invoice
      ee.emit 'invoices-new', invoice
      invoice.data.identifier().should_be 16


    it 'should set the disclaimer', ->

      invoice = new Invoice
      ee.emit 'invoices-new', invoice
      invoice.data.disclaimer().should_be \
      'This is a test disclaimer for testing'


    it 'should set the expiration', ->

      invoice = new Invoice
      ee.emit 'invoices-new', invoice
      invoice.data.expiration().should_be 99


    it 'should set the tax', ->

      invoice = new Invoice
      ee.emit 'invoices-new', invoice
      invoice.data.tax().should_be 21


    it 'should select the new invoice', ->

      invoice = new Invoice
      ee.emit 'invoices-new', invoice
      expect(invoice.selected()).toBeTruthy()


    it 'should tell that it wants to be saved', ->

      invoice = new Invoice
      spyOn ee, 'emit'
      subject.setDefaults invoice
      ee.emit.should_have_been_called_with 'invoices-save', invoice


  describe 'Save ->', ->

    it 'should save the invoice', ->

      invoice = new Invoice
      spyOn subject.repo, 'saveModel'
      ee.emit 'invoices-save', invoice
      subject.repo.saveModel.should_have_been_called_with \
      invoice.data, subject.adjustParts


    it 'should adjust the js', ->

      invoice = new Invoice
      invoice.createPart()
      invoice.data.parts()[0].data.cost '15'
      invoice.data.parts()[0].data.description 'description'

      spyOn subject.repo, 'save'
      ee.emit 'invoices-save', invoice
      parts = subject.repo.save.mostRecentCall.args[0].parts

      expect( parts[0] ).toEqual cost:'15', description:'description'


    it 'should remove __ko_mapping__', ->

      fakeParts =

        parts : [

          data :
            __ko_mapping__ : null
        ]

      subject.adjustParts fakeParts

      for part in fakeParts.parts

        expect(part.__ko_mapping__).toBeUndefined()


  describe 'Remove ->', ->

    
    it 'should remove the document', ->

      spyOn subject.repo, 'removeModel'
      invoice = new Invoice
      ee.emit 'invoices-remove', invoice
      subject.repo.removeModel.should_have_been_called_with invoice.data


  describe 'Get ->', ->


    it 'should call get repo with the id', ->

      spyOn subject.repo, 'get'

      subject.get {}, 'someid'
      subject.repo.get.should_have_been_called_with 'someid', jasmine.any(Function)


    describe 'Properties ->', ->


      invoice = null


      beforeEach ->

        invoice = new Invoice
        subject.get invoice, 'someinvoice'


      testProp = (prop, expect)->

        invoice.data[prop]().should_be expect


      it 'should all properties', ->
        
        testProp '_id', 'id1'
        testProp '_rev', 'rev1'
        testProp 'identifier', '1'
        #...
