Base = require '../repo'

class Data extends Base

  constructor : ->

    @database = 'porks'
    @view = 'Porks/allClients'
    super()

module.exports = Data
