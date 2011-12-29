class Observer

  constructor : (data, fn, ignore=[])->

    @listen = false

    result = ko.dependentObservable ->
      for key, val of data
        if ko.isObservable(val) and key not in ignore
          val()

    result.subscribe =>
      if @listen
        fn()


  start : -> @listen = true
  stop : -> @listen = false


module.exports = Observer
