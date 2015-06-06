function myFunction() {
    var numPeople = parseInt($('#numPeople').val());
    var startingSum = parseInt($('#startingSum').val());
    var iterations = parseInt($('#iterations').val());
    var demurragePercent = parseInt($('#demurragePercent').val());
    var transactPercent = parseInt($('#transactPercent').val());
    var transPerIter = parseInt($('#transPerIter').val());
    var transactionFund = 0;

    var accounts = [];

    var table = $('<table></table>');

    function addRow() {

        var row = $('<tr></tr>');
        var total = accounts.reduce(function(a, b) {
            return a + b;
        })+transactionFund;

        var average = function(a) {
            var r = {mean: 0, variance: 0, deviation: 0}, t = a.length;
            for (var m, s = 0, l = t; l--; s += a[l]);
            for (m = r.mean = s / t, l = t, s = 0; l--; s += Math.pow(a[l] - m, 2));
            return r.deviation = Math.sqrt(r.variance = s / t), r;
        };

        //function calcVariance() {
        //
        //    var x = 0;
        //    for (var i=0;i<numPeople;i++){
        //        x += (accounts[i]-startingSum)^2;
        //    }
        //    return Math.sqrt((1/(numPeople-1))*x)
        //}
        var x = average(accounts);

        row.append($('<td>' + transactionFund.toFixed(2) + //', T' + total.toFixed(2)+ //"<br />" +
    //    "mean      = " + x.mean.toFixed(2) + "<br />" +
    //"deviation = " + x.deviation.toFixed(2) + "<br />" +
    //"variance  = " + x.variance.toFixed(2)+
        '</td>'));
        for (var i = 0; i < numPeople; i++) {
            row.append($('<td>' + accounts[i].toFixed(2) + '</td>'));
        }
        table.append(row);
    }

    function generatePrice() {
        var x = Math.floor((Math.random() * 150) + 1);
        if (x > 50 && x<=100) {
            x = x / 2;
        }
        if (x >100)
        {
            x -= 50;
        }

        return x;
    }

    function randomTransaction() {
        var customer = Math.floor((Math.random() * numPeople) );
        var payee = Math.floor((Math.random() * numPeople) );
        while (payee == customer){
            payee = Math.floor((Math.random() * numPeople) );
        }


        var price = generatePrice();
        if (accounts[customer] >= price) {
            accounts[customer] -= price;
            var transTax = price * transactPercent / 100;
            transTax = transTax;
            transactionFund += transTax;
            accounts[payee] += price - transTax;
            console.log("Giving " + price + " from " + customer + " to " + payee);
        }


    }

    $('#results').prepend(table);

    var row = $('<tr></tr>');
    row.append('<th>Transaction Fund</th>')
    for (var i = 0; i < numPeople; i++) {
        row.append($('<th>' + i + '</th>'));
        accounts.push(startingSum);
    }
    table.append(row);


    function redistribute() {
        var redist = transactionFund / numPeople;
        for (var i = 0; i < numPeople; i++) {
            accounts[i] += redist;
        }
        transactionFund = 0;
    }

    function demurrage() {
        for (var i = 0; i < numPeople; i++) {
            if (accounts[i] > startingSum) {
                var dem = accounts[i] * demurragePercent*0.01;
                accounts[i] -= dem;
                transactionFund +=dem;
            }
        }
    }

    for (var i = 0; i < iterations; i++) {
        addRow();
        redistribute();
        for (var j=0;j<transPerIter;j++) {
            randomTransaction();
        }
        demurrage();

    }

}