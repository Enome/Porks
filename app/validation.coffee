Validation = kk.Validation
validators = kk.validators

Required = validators.Required
Email = validators.Email
Regex = validators.Regex
Number = validators.Number

positive_integer = [ /^\d+$/, 'Your entry didn\'t match a positive integer' ]
date = [
  /^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/,
  'Please fill in the correct date format ( 2011/11/29 ).'
]


exports.settings = (viewmodel)->

  validation = new Validation viewmodel,
    clientCounter  : new Regex positive_integer...
    invoiceCounter : new Regex positive_integer...
    expiration     : new Regex positive_integer...
    tax            : new Regex positive_integer...
  , false


exports.client = (viewmodel)->

  validation = new Validation viewmodel,
    identifier : new Required
    name       : new Required
    email      : new Email
  , false


exports.invoice = (viewmodel)->

  validation = new Validation viewmodel,
    identifier  : new Required
    date        : [ new Regex(date...), new Required ]
    closed_date : [ new Regex(date...) ]
    expiration  : [ new Regex(positive_integer...) , new Required ]
    tax         : new Regex positive_integer...
  , false


exports.part = (viewmodel)->

  validation = new Validation viewmodel,
    description : new Required
    cost        : [ new Number, new Required ]
  , false
