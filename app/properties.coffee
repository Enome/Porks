module.exports =

  views :

    allClients :
      map : (doc)->
        emit doc.identifier, doc if doc.type is 'Client'

    allSettings :
      map : (doc)->
        emit doc._id, doc if doc.type is 'Settings'

    allInvoices :
      map : (doc)->
        emit doc.identifier, doc if doc.type is 'Invoice'
