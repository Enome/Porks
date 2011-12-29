ee = require '../../../app/events'
Subject = require '../../../app/data/settings/events'
Settings = require '../../../app/viewmodels/settings'
resetEe = require '../../lib/ee'
eq = require('assert').equal

describe 'Data Events: Settings ->', ->


  subject = null

  beforeEach ->

    resetEe()
    subject = new Subject


  describe 'Constructor ->', ->

    beforeEach ->

      spyOn ee, 'on'
      subject = new Subject


    it 'should listen to settings-select', ->

      ee.on.should_have_been_called_with 'settings-select', subject.populate


    it 'should listen to settings-update', ->

      ee.on.should_have_been_called_with 'settings-update', subject.update


    it 'should listen to settings-get', ->

      ee.on.should_have_been_called_with 'settings-get', subject.populate


  describe 'Populate ->', ->


    testProp = (prop, expected)->
      settings = new Settings
      ee.emit 'settings-select', settings
      settings.data[prop]().should_be expected


    it 'should populate the _id', ->

      testProp '_id', 1


    it 'should populate the _rev', ->

      testProp '_rev', 1


    it 'should populate the clientCounter', ->

      testProp 'clientCounter', 11


    it 'should populate the invoiceCounter', ->

      testProp 'invoiceCounter', 15


    it 'should populate the disclaimer', ->

      testProp 'disclaimer', 'This is a test disclaimer for testing'


    it 'should populate the expiration', ->

      testProp 'expiration', 99


    it 'should populate the tax', ->

      testProp 'tax', 21


  describe 'Default ->', ->

    
    settings = null

    beforeEach ->

      settings = new Settings
      spyOn settings, 'update'
      subject.repo.all = (cb)-> cb []
      ee.emit 'settings-select', settings


    testProp = (prop, expected)->

      expect(settings.data[prop]()).toEqual expected


    it 'should not populate the _id', ->

      testProp '_id', undefined


    it 'should not populate the _rev', ->

      testProp '_rev', undefined


    it 'should populate the clientCounter', ->

      testProp 'clientCounter', 0


    it 'should populate the invoiceCounter', ->

      testProp 'invoiceCounter', 0


    it 'should populate the disclaimer', ->

      testProp 'disclaimer', ''


    it 'should populate the expiration', ->

      testProp 'expiration', 14


    it 'should populate the tax', ->

      testProp 'tax', 21


    it 'should save the data after defaults have been set', ->

      settings.update.should_have_been_called()

    
  describe 'Update ->', ->


    it 'should save the settings', ->

      subject  = new Subject
      settings = new Settings

      spyOn subject.repo, 'saveModel'
      subject.update settings
      subject.repo.saveModel.should_have_been_called_with settings.data
