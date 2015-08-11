window.CurrencyModel = {} if !window.CurrencyModel
window.CurrencyModel.myFunction = ->
    numPeople = parseInt($('#numPeople').val())
    startingSum = parseInt($('#startingSum').val())
    iterations = parseInt($('#iterations').val())
    demurragePercent = parseInt($('#demurragePercent').val())
    transactPercent = parseInt($('#transactPercent').val())
    transPerIter = parseInt($('#transPerIter').val())
    transactionFund = 0
    accounts = []
    table = $('<table></table>')

    buildGraph = (data) ->
        ctx = document.getElementById("myChart").getContext("2d")
        new Chart(ctx).Line(data, {
            datasetFill:false
            pointDot:false
        })

    addRow = ->
        row = $('<tr></tr>')
        total = transactionFund
        total += acc.balance for acc in accounts

        average = (accounts) ->
            r = {}
            t = accounts.length
            s = 0
            s += acc.balance for acc in accounts
            r.mean = s / t
            s = 0
            for acc in accounts
                s += (acc.balance - r.mean) ** 2
            r.deviation = Math.sqrt(r.variance = s / t)
            r

        x = average(accounts)
        row.append $('<td>' + transactionFund.toFixed(2) +
            #        ', T' + total.toFixed(2)+ "<br />" +
            #        "mean      = " + x.mean.toFixed(2) + "<br />" +
            #        "deviation = " + x.deviation.toFixed(2) + "<br />" +
            #        "variance  = " + x.variance.toFixed(2)+
            '</td>')
        for acc in accounts
            row.append $('<td>' + acc.balance.toFixed(2) + '</td>')
        table.append row
        return

    generatePrice = (bigSpender) ->
        x = Math.floor(Math.random() * 150 + 1)

        if x > 50 and x <= 100 and not bigSpender
            x -= 50

        if x > 100
            x -= 50
        x

    GetBuyer = ->
        Math.floor(Math.random() * numPeople)

    GetSeller = ->
        seller = Math.floor(Math.random() * numPeople)
        # if we haven't chosen a big seller, 50/50 chance of choosing again
        if (not accounts[seller].sellsAlot)
            seller = Math.floor(Math.random() * numPeople) if Math.random() > 0.5
        seller

    randomTransaction = ->
        buyer = GetBuyer()
        seller = GetSeller()
        while seller == buyer
            seller = GetSeller()
        price = generatePrice(accounts[buyer].bigSpender)
        if accounts[buyer].balance >= price
            accounts[buyer].balance -= price
            transTax = price * transactPercent / 100
            transTax = transTax
            transactionFund += transTax
            accounts[seller].balance += price - transTax
#            console.log 'Giving ' + price + ' from ' + customer + ' to ' + payee
        return

    redistribute = ->
        redist = transactionFund / numPeople
        for acc in accounts
            acc.balance += redist
        transactionFund = 0

    demurrage = ->
        for acc in accounts
#      if acc.balance > startingSum
            dem = acc.balance * demurragePercent * 0.01
            acc.balance -= dem
            transactionFund += dem

    addDataToGraph = ->
        for i  in [0..numPeople-1]
            data.datasets[i].data.push accounts[i].balance
        data.labels.push data.datasets[0].data.length

    $('#results').prepend table
    row = $('<tr></tr>')
    row.append '<th>Transaction Fund</th>'

    data =
        labels:[]
        datasets:[]

#    add header and initialise accounts
    for i in [1..numPeople]
        row.append $('<th>' + i + '</th>')
        accounts.push (acc = new window.CurrencyModel.Account(startingSum))

        lineColorR = if acc.bigSpender then 256 else 0
        lineColorG = if acc.sellsAlot then 256 else 0
        lineColorB = if acc.bigSpender or acc.sellsAlot then 0 else Math.floor(Math.random() * 256 + 1)
        data.datasets.push (
            label:"User " + i
            data:[]
            fillColor: "rgba(220,220,220,0)"
            strokeColor: "rgba("+lineColorR+","+lineColorG+","+lineColorB+",1)"
            pointDot: false
#            pointDotRadius : 1
#            pointColor: "rgba(220,220,220,1)"
#            pointStrokeColor: "#fff"
#            pointHighlightFill: "#fff"
#            pointHighlightStroke: "rgba(220,220,220,1)"
        )
    table.append row

#    run the main loop of iterations
    for i in [1..iterations - 1]
        addRow()
        addDataToGraph()
        redistribute()
        for j in [1..transPerIter - 1]
            randomTransaction()
        demurrage()

    buildGraph(data)

