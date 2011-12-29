couch = require '../libs/couch'

class Base

  constructor : ->

    @db = couch.db @database


  data : (callback)->

    @db.view @view,
      success : (data) ->
        callback( row.value for row in data.rows )


  all : (callback)->

    @data callback


  get : (id, callback)->

    @db.openDoc id, success:callback


  getByKey : (keys, callback)->

    @db.view @view,
      success: callback
      keys: keys


  saveModel : (model, callback=->)->

    js = ko.toJS model
    delete js?.__ko_mapping__

    callback js

    @save js, (resp)->

      model._id resp.id
      model._rev resp.rev


  save : ( js, success=-> )->

    @db.saveDoc js, success : success


  removeModel : (model)->

    @remove ko.mapping.toJS model


  remove : (doc)->

    @db.removeDoc doc


  bulkRemove : (docs, options)->

    @db.bulkRemove docs, options


module.exports = Base
