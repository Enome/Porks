Invoice = require '../../app/viewmodels/invoice'
Part = require '../../app/viewmodels/part'
ee = require '../../app/events'
assert = require 'assert'
resetEe = require '../lib/ee'


describe 'Viewmodel: Invoice ->', ->


  beforeEach -> resetEe()


  describe  'Date ->', ->


    it 'should get the date of today as yyyy/MM/dd', ->

      toString = jasmine.createSpy()
      spyOn(Date, 'today').andReturn toString:toString
      new Invoice
      Date.today().toString.should_have_been_called_with 'yyyy/MM/dd'

    
    it 'should set date to today', ->

      invoice = new Invoice
      invoice.data.date().should_be Date.today().toString 'yyyy/MM/dd'


  describe 'fullname ->', ->


    it 'should return identifier + date', ->

      invoice = new Invoice
      invoice.data.identifier 2
      invoice.fullname().should_be "2 - #{Date.today().toString('yyyy/MM/dd')}"

  
  describe 'Status ->', ->


    it 'should return closed', ->

      invoice = new Invoice
      invoice.data.closed_date '2011/11/11'
      invoice.status().should_be 'closed'


    it 'should return open', ->

      invoice = new Invoice
      invoice.data.closed_date()
      invoice.status().should_be 'open'


  describe 'Selected ->', ->


    it 'should not be select by default', ->

      invoice = new Invoice
      expect(invoice.selected()).toBeFalsy()


    it 'should set selected to true', ->

      invoice = new Invoice
      invoice.select()
      expect(invoice.selected).toBeTruthy()

    it 'should tell that it is selected', ->

      spyOn ee, 'emit'
      invoice = new Invoice
      invoice.select()
      ee.emit.should_have_been_called_with 'invoice-select', invoice


    it 'should deselect when an other invoice gets selected', ->

      invoice = new Invoice
      invoice.selected true
      ee.emit 'invoice-select'
      expect(invoice.selected()).toBeFalsy()


    it 'should not deselect when its the invoice thats being selected', ->

      invoice = new Invoice
      invoice.selected true

      ee.emit 'invoice-select', invoice
      expect(invoice.selected()).toBeTruthy()


    it 'should deselect when client is selected', ->

      invoice = new Invoice
      invoice.selected true
      ee.emit 'client-select'
      expect(invoice.selected()).toBeFalsy()


  describe 'Part ->', ->


    it 'should create a part', ->

      invoice = new Invoice
      invoice.createPart()
      invoice.data.parts().length.should_be 1


    it 'should be an instance of Part', ->

      invoice = new Invoice
      invoice.createPart()
      assert.ok invoice.data.parts()[0] instanceof Part


    it 'should tell that a new part was created', ->

      invoice = new Invoice
      spyOn ee, 'emit'
      invoice.createPart()
      ee.emit.should_have_been_called_with 'parts-new', invoice.data.parts()[0]


  describe 'Save ->', ->


    it 'should advertise it wants to be saved', ->

      spyOn ee, 'emit'
      invoice = new Invoice
      invoice.save()
      ee.emit.should_have_been_called_with 'invoices-save', invoice

  
  describe 'Save Part ->', ->

    
    it 'should listen to parts-save', ->

      spyOn ee, 'on'
      invoice = new Invoice
      ee.on.should_have_been_called_with 'parts-save', invoice.savePart


    it 'should save the invoice if parts contains part', ->

      part = new Part
      invoice = new Invoice
      spyOn invoice, 'save'
      invoice.data.parts.push part
      ee.emit 'parts-save', part
      invoice.save.should_have_been_called()


    it 'should not save the invoice if parts doesnt contains part', ->

      part = new Part
      invoice = new Invoice
      invoice.data.identifier 'this is the one'
      spyOn invoice, 'save'
      ee.emit 'parts-save', part
      invoice.save.should_have_not_been_called()


  describe 'Remove ->', ->


    it 'should tell that it wants to be removed', ->

      spyOn ee, 'emit'
      invoice = new Invoice
      invoice.remove()
      ee.emit.should_have_been_called_with 'invoices-remove', invoice


   it 'should deselect the invoice', ->

     invoice = new Invoice
     invoice.select()
     invoice.remove()
     expect( invoice.selected() ).toBeFalsy()


   it 'should tell that it wants to be deselected', ->

      spyOn ee, 'emit'
      invoice = new Invoice
      invoice.remove()
      ee.emit.should_have_been_called_with 'invoices-deselect', invoice


  describe 'Remove Part ->', ->

    
    it 'should remove the invoice', ->

      part = new Part
      invoice = new Invoice
      invoice.data.parts.push part
      invoice.removePart part

      invoice.data.parts.indexOf(part).should_be -1


  describe 'Calculate ->', ->


    part1 = part2 = part3 = part4 = null
    invoice1 = invoice2 = invoice3 = null


    beforeEach ->

      part1 = new Part
      part1.data.cost '5.11'

      part2 = new Part
      part2.data.cost ''

      part3 = new Part
      part3.data.cost '6'

      part4 = new Part
      part4.data.cost '-10.22'

      invoice1 = new Invoice
      invoice1.data.tax 21
      invoice1.data.parts [ part1, part2 ]

      invoice2 = new Invoice
      invoice2.data.tax 6
      invoice2.data.parts [ part3, part1, part4 ]

      invoice3 = new Invoice
      invoice3.data.parts [ part3, part1, part4 ]


    describe 'subtotal ->', ->


      it 'should return 10.33', ->

        invoice1.calculateSubtotal().toString().should_be '5.11'


      it 'should return 0.89', ->

        invoice2.calculateSubtotal().toString().should_be '0.89'


    describe 'tax ->', ->


      it 'should be 21% of 5.11 that should equal 1.0731', ->

        invoice1.calculateTax().toString().should_be '1.0731'


      it 'should be 6% of 0.89 should equal 0.0534', ->

        invoice2.calculateTax().toString().should_be '0.0534'

      it 'should be 0', ->

        invoice3.calculateTax().toString().should_be '0'


    describe 'total ->', ->

      
      it 'should return 6.1831', ->

        invoice1.calculateTotal().toString().should_be '6.1831'


      it 'should return 0.9434', ->

        invoice2.calculateTotal().toString().should_be '0.9434'


      it 'should return 0.89', ->

        invoice3.calculateTotal().toString().should_be '0.89'



  describe 'Print url ->', ->


    it 'should return print.html#12345', ->

      invoice = new Invoice
      invoice.data._id '12345'
      invoice.printLink().should_be 'print.html#12345'
      


  describe 'Calculate expiration date ->', ->


    it 'should return 1982/11/29', ->

      invoice = new Invoice
      invoice.data.date '1982/11/20'
      invoice.data.expiration 9
      invoice.expirationDate().should_be '1982/11/29'


