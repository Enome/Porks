Part = require '../../viewmodels/part'


class Map


  map : (d, invoice)->

    invoice.data._id         d._id
    invoice.data._rev        d._rev
    invoice.data.identifier  d.identifier
    invoice.data.date        d.date
    invoice.data.closed_date d.closed_date
    invoice.data.expiration  d.expiration
    invoice.data.tax         d.tax
    invoice.data.disclaimer  d.disclaimer
    invoice.data.clientId    d.clientId

    invoice.data.parts( @mapPart p for p in d.parts )
    invoice


  mapPart : (d)->

    part = new Part
    ko.mapping.fromJS d, {}, part.data
    part.observer.start()
    part


module.exports = Map
