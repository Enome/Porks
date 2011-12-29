ee = require '../events'
Part = require './part'
Observer = require '../observer'
validation = require('../validation').invoice
Decimal = require('../libs/decimal')

class Invoice

  constructor : ->
    
    @data =
      type : 'Invoice'
      _id  : ko.observable()
      _rev : ko.observable()

      identifier  : ko.observable()
      date        : ko.observable Date.today().toString 'yyyy/MM/dd'
      closed_date : ko.observable()
      expiration  : ko.numericObservable()
      tax         : ko.numericObservable()
      disclaimer  : ko.observable()
      clientId    : ko.observable()
      parts       : ko.observableArray()

    @d          = @data
    @selected   = ko.observable(false)
    @validation = validation @data
    @observer   = new Observer @data, @save, [ '_id', '_rev' ]
    @fullname   = ko.dependentObservable => "#{@data.identifier()} - #{@data.date()}"
    @status     = ko.dependentObservable => if @data.closed_date() then 'closed' else 'open'
    @printLink  = ko.dependentObservable => "print.html##{@data._id()}"
    @expirationDate = ko.dependentObservable =>

      if @data.date() and @data.expiration()
        date = Date.parseExact @data.date(), 'yyyy/MM/dd'
        date.add(@data.expiration()).days()
        date.toString 'yyyy/MM/dd'

    @subTotal = ko.dependentObservable => @calculateSubtotal()?.toNumber().toFixed 2
    @tax      = ko.dependentObservable => @calculateTax()?.toNumber().toFixed 2
    @total    = ko.dependentObservable => @calculateTotal()?.toNumber().toFixed 2

    ee.on 'invoice-select', (invoice)=> @selected false if this isnt invoice
    ee.on 'client-select' , => @selected false
    ee.on 'parts-save'    , @savePart
  

  save : =>

    ee.emit 'invoices-save', this


  savePart : (part)=>

    if @data.parts.indexOf(part) isnt -1

      @save()


  removePart : (part)=>

    @data.parts.remove part


  createPart : ->

    part = new Part
    @data.parts.push part
    part.observer.start()
    ee.emit 'parts-new', part


  select : ->

    @selected true
    ee.emit 'invoice-select', this


  remove : ->

    @selected false
    ee.emit 'invoices-remove', this
    ee.emit 'invoices-deselect', this


  calculateSubtotal : =>

    base = new Decimal '0'

    for part in @data.parts()
      if part.data.cost()
        base = base.add part.data.cost()

    base
    

  calculateTax : =>

    if @data.tax()

      percentage = Decimal( @data.tax() ).div('100')
      Decimal( @calculateSubtotal() ).mul( percentage )

    else
      Decimal('0')

  
  calculateTotal : =>

    if @calculateTax()
      Decimal( @calculateSubtotal() ).add @calculateTax()


module.exports = Invoice
