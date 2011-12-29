Settings = require '../../app/viewmodels/settings'
ee = require '../../app/events'


describe 'Settings', ->


  describe 'Client counter', ->


    it 'should return clientCounter plus one', ->

      settings = new Settings
      settings.data.clientCounter 1234
      settings.getClientCounter().should_be 1235


  describe 'Invoice counter', ->


    it 'should return invoiceCounter plus one', ->

      settings = new Settings
      settings.data.invoiceCounter 1000
      settings.getInvoiceCounter().should_be 1001


  describe 'Select', ->


    it 'should set select', ->

      settings = new Settings
      settings.select()
      expect(settings.selected()).toBeTruthy()


    it 'shouldn\'t be selected by default', ->

      settings = new Settings
      expect(settings.selected()).toBeFalsy()


    it 'should tell that it was selected', ->

      spyOn ee, 'emit'
      settings = new Settings
      settings.select()
      ee.emit.should_have_been_called_with 'settings-select', settings


    it 'should stop observing changes before it gets selected', ->

      settings = new Settings
      spyOn settings.observer, 'stop'
      settings.select()
      settings.observer.stop.should_have_been_called()


  describe 'Update ->', ->


    it 'should call update when data is changed', ->

      spyOn Settings.prototype, 'update'
      settings = new Settings
      settings.observer.start()
      settings.data.clientCounter 15
      Settings.prototype.update.should_have_been_called()


    it 'should tell the world that it wants to be updated', ->

      spyOn ee, 'emit'
      settings = new Settings
      settings.update()
      ee.emit.should_have_been_called_with 'settings-update', settings


    it 'should not update when _id is changed', ->

      spyOn Settings.prototype, 'update'
      settings = new Settings
      settings.observer.start()
      settings.data._id 15
      Settings.prototype.update.should_have_not_been_called()


    it 'should not update when _rev is changed', ->

      spyOn Settings.prototype, 'update'
      settings = new Settings
      settings.observer.start()
      settings.data._rev 15
      Settings.prototype.update.should_have_not_been_called()


