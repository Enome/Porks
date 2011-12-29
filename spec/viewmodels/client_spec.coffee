Subject = require '../../app/viewmodels/client'
Invoice = require '../../app/viewmodels/invoice'
ee = require '../../app/events'
resetEvents = require '../lib/ee'


describe 'Viewmodel: Client ->', ->


  subject = invoice = null


  beforeEach ->

    resetEvents()
    subject = new Subject
    invoice = new Invoice

    subject.invoices.push invoice


  describe 'Save ->', ->


    it 'should tell that it wants to be saved', ->
      
      spyOn ee, 'emit'
      subject.save()
      ee.emit.should_have_been_called_with 'clients-save', subject
      

  describe 'Remove ->', ->


    it 'should tell that it wants to be deleted', ->

        spyOn ee, 'emit'
        subject.remove()
        ee.emit.should_have_been_called_with 'clients-remove', subject


    it 'should deselect the client', ->

      subject.selected true
      subject.remove()
      expect( subject.selected() ).toBeFalsy()


    it 'should tell that it\'s getting deselected', ->

      spyOn ee, 'emit'
      subject.remove()
      ee.emit.should_have_been_called_with 'client-deselect', subject


  describe 'Create Invoices', ->


    it 'should add a new invoice to invoices', ->

      subject.createInvoice()
      subject.invoices().length.should_be 2


    it 'should tell that it created a new client', ->

      spyOn ee, 'emit'
      subject.createInvoice()
      ee.emit.should_have_been_called_with 'invoices-new', subject.invoices()[0]


    it 'should set the clientId', ->
      
      subject.data._id 'subject id'
      subject.createInvoice()
      subject.invoices()[0].data.clientId().should_be 'subject id'


  describe 'Select ->', ->


    it 'should tell that it wants to be selected', ->

      spyOn ee, 'emit'
      subject.select()
      ee.emit.should_have_been_called_with 'client-select', subject


    it 'should set selected to true', ->

      subject.select()
      expect(subject.selected()).toBeTruthy()


    it 'should be false by default', ->

      expect(subject.selected()).toBeFalsy()


    it 'should deselect when an other subject gets selected', ->

      subject.selected true
      ee.emit 'client-select'
      expect(subject.selected()).toBeFalsy()

    
    it 'should load the invoices', ->

      spyOn ee, 'emit'
      subject.select()
      ee.emit.should_have_been_called_with 'client-invoices', subject


  describe 'Deselect ->', ->

    it 'should set select to false', ->

      subject.selected true
      subject.deselect()
      expect( subject.selected() ).toEqual false


  describe 'Dependent Observables ->', ->


    describe 'fullname', ->


      it 'should show identifier plus name', ->

        subject.data.identifier 1
        subject.data.name 'Jimi'
        subject.fullname().should_be '1 Jimi'


  describe 'Remove Invoice ->', ->


    it 'should listen to invoices-remove', ->

      spyOn ee, 'on'
      subject = new Subject
      ee.on.should_have_been_called_with 'invoices-remove', subject.invoiceRemove


    it 'should remove the invoice', ->

      ee.emit 'invoices-remove', invoice
      subject.invoices().length.should_be 0


    it 'should remove the invoice from the right client', ->

      invoice2 = new Invoice
      subject2 = new Subject

      subject2.invoices.push invoice2

      ee.emit 'invoices-remove', invoice
      subject2.invoices().length.should_be 1
