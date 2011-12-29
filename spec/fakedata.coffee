exports.clients = ->

  [
    {
      "type" : "Client"
      "_id" : "randomid1"
      "_rev" : "rev1"
      "name" : "Benny"
      "identifier" : "1"
      "email" : "benny@foo.com"
      "phone" : "099 999 999"
      "registration_number" : "123"
      "bank" : "123"
      "street_number" : "somestreet 321"
      "zipcode" : "b-1234"
      "place" : "somewhere"
      "invoices" : []
    }

    {
      "type" : "Client"
      "_id" : "randomid2"
      "_rev" : "rev2"
      "name" : "Jimmi"
      "identifier" : "2"
      "email" : "jimmi@foo.com"
      "phone" : "099 888 888"
      "registration_number" : "231"
      "bank" : "231"
      "street_number" : "somestreet 213"
      "zipcode" : "b-2314"
      "place" : "placesome"
      "invoices" : []
    }

    {
      "type" : "Client"
      "_id" : "randomid3"
      "_rev" : "rev3"
      "name" : "Katie"
      "identifier" : "3"
      "email" : "katie@foo.com"
      "phone" : "099 777 777"
      "registration_number" : "312"
      "bank" : "312"
      "street_number" : "somestreet 132"
      "zipcode" : "b-4321"
      "place" : "someplace"
      "invoices" : []
    }

  ]


exports.invoices = ->

  [
    {
      "type" : "Invoice"
      "_id" : "id1"
      "_rev" : "rev1"
      "identifier" : "1"
      "date" : "2011/11/29"
      "expiration" : 14
      "tax" : 21
      "disclaimer" : "Please pay us!"
      "clientId" : "randomid3"
      "parts" : [

        {
          "cost" : "15.00"
          "description" : "This is a description"
        }

        {
          "cost" : "12.99"
          "description" : "This is a description"
        }

        {
          "cost" : "2.89"
          "description" : "This is a description"
        }

      ]
    }

    {
      "type" : "Invoice"
      "_id" : "id2"
      "_rev" : "rev2"
      "identifier" : "2"
      "date" : "2011/08/07"
      "expiration" : 14
      "tax" : 21
      "disclaimer" : "Please pay us!"
      "clientId" : "randomid1"
      "parts" : [

        {
          "cost" : "15.00"
          "description" : "This is a description"
        }

        {
          "cost" : "12.99"
          "description" : "This is a description"
        }

      ]
    }

    {
      "type" : "Invoice"
      "_id" : "id3"
      "_rev" : "rev3"
      "identifier" : "3"
      "date" : "2011/05/11"
      "expiration" : 14
      "tax" : 21
      "disclaimer" : "Please pay us!"
      "clientId" : "randomid1"
      "parts" : [

        {
          "cost" : "15.00"
          "description" : "This is a description"
        }

        {
          "cost" : "12.99"
          "description" : "This is a description"
        }

      ]
    }

    {
      "type" : "Invoice"
      "_id" : "id4"
      "_rev" : "rev4"
      "identifier" : "4"
      "date" : "2011/02/01"
      "expiration" : 14
      "tax" : 21
      "disclaimer" : "Please pay us!"
      "clientId" : "randomid1"
      "parts" : [

        {
          "cost" : "15.00"
          "description" : "This is a description"
        }

        {
          "cost" : "12.99"
          "description" : "This is a description"
        }

      ]
    }

  ]

exports.settings = ->

  _id : 1
  _rev : 1
  clientCounter : 11
  invoiceCounter : 15
  disclaimer : 'This is a test disclaimer for testing'
  expiration : 99
  tax : 21
