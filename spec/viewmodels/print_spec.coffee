ee = require '../../app/events'
Print = require '../../app/viewmodels/print'
resetEe = require '../lib/ee'


describe 'Print ->', ->


  beforeEach -> resetEe()


  describe 'Hash ->', ->


    it 'should not has # sign in hash', ->

      window.location.hash = '#testhash'
      p = new Print
      p.hash.should_be 'testhash'


  describe 'Invoice ->', ->


    it 'should tell that it wants to populate invoice', ->

      spyOn ee, 'emit'

      p = new Print
      ee.emit.should_have_been_called_with 'invoices-get', p.invoice, p.hash


  describe 'Settings ->', ->


    it 'should tell that it wants to be populated', ->

      spyOn ee, 'emit'

      p = new Print
      ee.emit.should_have_been_called_with 'settings-get', p.settings


  describe 'Clients ->', ->


    it 'should tell that itsme needs to be populated', ->

      spyOn ee, 'emit'

      p = new Print
      ee.emit.should_have_been_called_with 'clients-itsme', '0', p.itsme


    it 'should emit when clientId is populated', ->

      spyOn ee, 'emit'
      p = new Print
      p.invoice.data.clientId 'someid'
      ee.emit.should_have_been_called_with 'clients-get', p.you, 'someid'
