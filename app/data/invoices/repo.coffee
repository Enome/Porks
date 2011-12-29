Base = require '../repo'
Invoice = require '../../viewmodels/invoice'

class Data extends Base

  constructor : ->

    @database = 'porks'
    @view = 'Porks/allInvoices'
    super()


  clientInvoices : (client, callback)->

    @all (invoices)->

      callback( invoice \
                for invoice in invoices \
                when invoice.clientId is client.data._id() )


  removeClientInvoices : (client, callback)=>

    @clientInvoices client, (invoices)=>

      @bulkRemove { docs : invoices }, {}


module.exports = Data
