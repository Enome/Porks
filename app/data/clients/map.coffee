
class ClientMap

  map : (data, client)->

    client.data._rev                 data._rev
    client.data._id                  data._id
    client.data.identifier           data.identifier
    client.data.name                 data.name
    client.data.registration_number  data.registration_number
    client.data.email                data.email
    client.data.bank                 data.bank
    client.data.street_number        data.street_number
    client.data.zipcode              data.zipcode
    client.data.place                data.place

    client


module.exports = ClientMap
