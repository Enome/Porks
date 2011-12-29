Subject = require '../../app/viewmodels/part'
ee = require '../../app/events'
resetEe = require '../lib/ee'

describe 'Viewmodel: Part ->', ->


  beforeEach ->

    resetEe()


  describe 'Save ->', ->


    it 'should tell it wants to be saved', ->

      subject = new Subject
      spyOn ee, 'emit'
      subject.save()
      ee.emit.should_have_been_called_with 'parts-save', subject
