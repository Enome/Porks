ko.numericObservable = (initialValue) ->

  _actual = ko.observable(initialValue)

  result = ko.dependentObservable
    read: _actual
    write: (newValue) ->
      parsedValue = parseFloat(newValue)
      _actual (if isNaN(parsedValue) then newValue else parsedValue)

  result
