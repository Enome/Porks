exports.isNumber = (n)->
  not isNaN(parseFloat(n)) and isFinite(n)
