ee = require '../../app/events'
resetEe = require '../lib/ee'
Subject = require '../../app/viewmodels/selected'


describe 'Viewmodel: Selected ->', ->

  mock = subject = null


  beforeEach ->

    resetEe()
    subject = new Subject

    mock =
      observer   : { start : jasmine.createSpy() }
      validation : { validate : jasmine.createSpy() }


  describe 'Client ->', ->


    it 'should set client', ->

      ee.emit 'client-select', mock
      expect(subject.client()).toBe mock


    it 'should clear invoice', ->

      subject.invoice 'some invoice'
      ee.emit 'client-select', mock
      expect(subject.invoice()).toBeNull()


    it 'should clear settings', ->

      subject.settings 'some settings'
      ee.emit 'client-select', mock
      expect(subject.settings()).toBeNull()


    it 'should validate client', ->

      ee.emit 'client-select', mock
      mock.validation.validate.should_have_been_called()


    it 'should observe the client for changes', ->

      ee.emit 'client-select', mock
      mock.observer.start.should_have_been_called()


    it 'should listen to client-deselect', ->

      spyOn ee, 'on'
      subject = new Subject
      ee.on.should_have_been_called_with 'client-deselect', subject.clearAll


  describe 'Invoice ->', ->


    it 'should set invoice', ->

      ee.emit 'invoice-select', mock
      expect(subject.invoice()).toEqual mock


    it 'should clear client', ->

      subject.client 'some client'
      ee.emit 'invoice-select', mock
      expect(subject.client()).toBeNull()


    it 'should clear settings', ->

      subject.settings 'some settings'
      ee.emit 'invoice-select', mock
      expect(subject.settings()).toBeNull()


    it 'should validate invoice', ->

      ee.emit 'invoice-select', mock
      mock.validation.validate.should_have_been_called()


    it 'should observe the invoice for changes', ->

      ee.emit 'invoice-select', mock
      mock.observer.start.should_have_been_called()


    it 'should listen to client-deselect', ->

      spyOn ee, 'on'
      subject = new Subject
      ee.on.should_have_been_called_with 'invoices-deselect', subject.clearAll


  describe 'Settings ->', ->


    it 'should set settings', ->

      ee.emit 'settings-select', mock
      expect(subject.settings()).toEqual mock


    it 'should clear client', ->

      subject.client 'some client'
      ee.emit 'settings-select', mock
      expect(subject.client()).toBeNull()


    it 'should clear invoice', ->

      subject.invoice 'some client'
      ee.emit 'settings-select', mock
      expect(subject.invoice()).toBeNull()


    it 'should run validation', ->

      ee.emit 'settings-select', mock
      mock.validation.validate.should_have_been_called()

