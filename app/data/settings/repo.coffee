Base = require '../repo'

class Data extends Base

  constructor : ->

    @database = 'porks'
    @view = 'Porks/allSettings'
    super()


  settings : (callback)->

    @all (settings)=>

      callback settings[0]


  clientCounter : (callback)=>

    @settings (settings)=>

      callback settings.clientCounter += 1
      @save settings
      

  invoiceCounter : (callback)=>

    @settings (settings)=>

      callback settings.invoiceCounter += 1
      @save settings


module.exports = Data
