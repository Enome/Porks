validation = require('../validation').part
Observer = require '../observer'
ee = require '../events'


class Part

  constructor : (@invoice)->

    @data =
      description : ko.observable()
      cost : ko.observable()

    @d = @data
    @validation = validation(@data)
    @observer = new Observer @data, @save


  save : =>

    ee.emit 'parts-save', this


module.exports = Part
