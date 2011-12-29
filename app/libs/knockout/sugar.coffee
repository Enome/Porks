ko = require './knockout'

ko.observable.fn.add = (o)-> @( @() + o )
ko.dependentObservable.fn.add = (o)-> @( @() + o )
ko.observable.fn.subtract = (o)-> @( @() - o )
ko.dependentObservable.fn.subtract = (o)-> @( @() - o )
