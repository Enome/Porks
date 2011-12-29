Observable = require '../app/observer'

describe 'Observer ->', ->

  vm = fn = o = null

  beforeEach ->

    vm =
      somevalue       : ko.observable()
      othervalue      : ko.observable()
      yetanothervalue : ko.observable()
      somevalues      : ko.observableArray [
        {
          somevalue : ko.observable()
        }
      ]

    fn = jasmine.createSpy()
    o = new Observable vm, fn, ['yetanothervalue']
    o.listen = true


  it 'should execute fn if one of the observables changed', ->

    vm.somevalue 'somevalue'
    fn.should_have_been_called()


  it 'should not execute fn if none of the observables changed', ->

    fn.should_have_not_been_called()

  
  describe 'Listen ->', ->


    it 'should not execute fn if listen is false', ->

      o.listen = false
      vm.somevalue 'somevalue'
      fn.should_have_not_been_called()


    it 'should not execute fn by default', ->

      delete o.listen
      vm.somevalue 'somevalue'
      fn.should_have_not_been_called()


    describe 'Start ->', ->

      it 'should change listen to true', ->

        o.start()
        expect(o.listen).toBeTruthy()


    describe 'Stop ->', ->

      it 'should change listen to false', ->

        o.stop()
        expect(o.listen).toBeFalsy()


    describe 'Ignore ->', ->

      it 'should not call fn when ignored properties get changed', ->

        vm.yetanothervalue 'yetanothervalue'
        fn.should_have_not_been_called()
