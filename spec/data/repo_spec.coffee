Subject = require '../../app/data/repo'

#This Base class was extracted from client repo. 
#So some tests are in the /client/repo_spec.coffee file.
#

describe 'Base Repo: ->', ->


  describe 'Remove ->', ->


    it 'should use removeDoc', ->

      doc = test:'test'
      subject = new Subject
      spyOn subject.db, 'removeDoc'
      subject.remove doc
      subject.db.removeDoc.should_have_been_called_with doc


  describe 'Remove Model ->', ->


    it 'should remove the model', ->


      subject = new Subject
      spyOn subject, 'remove'

      doc = test:'test'
      options = {}
      model = ko.mapping.fromJS doc
      subject.removeModel model
      subject.remove.should_have_been_called_with doc


  describe 'Bulk Remove ->', ->

    
    it 'should use bulkRemove', ->

      subject = new Subject
      spyOn subject.db, 'bulkRemove'
      docs = []
      options = {}
      subject.bulkRemove docs, options
      subject.db.bulkRemove.should_have_been_called_with docs, options


  describe 'Save Model ->', ->


    it 'should pass the js to the callback', ->

      fakemodel =
        _id : ko.observable('id')
        _rev : ko.observable('rev')

      subject = new Subject
      callback = jasmine.createSpy()
      subject.saveModel fakemodel, callback
      callback.should_have_been_called_with _id:'id', _rev:'rev'


  describe 'Get ->', ->


    it 'should call openDoc with id and success callback', ->


      subject = new Subject
      spyOn subject.db, 'openDoc'
      callback = ->
      subject.get 'someid', callback
      subject.db.openDoc.should_have_been_called_with 'someid', success:callback

