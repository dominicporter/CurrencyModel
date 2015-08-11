class Account
    constructor: (@balance, @bigSpender)->
        @bigSpender = if Math.random() > 0.5 then true else false
        @sellsAlot= if Math.random() > 0.5 then true else false
#        console.log(@buysAlot + " - " + @sellsAlot)

window.CurrencyModel = {} if !window.CurrencyModel
window.CurrencyModel.Account = Account