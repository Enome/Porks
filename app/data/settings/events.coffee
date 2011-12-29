ee = require '../../events'
Repo = require './repo'

class Events


  constructor : ->
    
    ee.on 'settings-select', @populate
    ee.on 'settings-update', @update
    ee.on 'settings-get'   , @populate

    @repo = new Repo


  populate : (settings)=>

    @repo.all (data)->

      first = data[0]

      if first
        ko.mapping.fromJS first, {}, settings.data

      else
        settings.data.clientCounter 0
        settings.data.invoiceCounter 0
        settings.data.disclaimer ''
        settings.data.expiration 14
        settings.data.tax 21
        settings.update()

      settings.observer.start()


  update : (settings)=>

    @repo.saveModel settings.data

module.exports = Events
