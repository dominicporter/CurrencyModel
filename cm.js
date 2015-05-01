function myFunction() {
    var numPeople = parseInt($('#numPeople').val());
    var startingSum = parseInt($('#startingSum').val());

    var table = $('<table></table>');
    $('body').append(table);

    var row = $('<tr></tr>');
    for (var i = 0;i < numPeople;i++){
        row.append($('<th>' + i + '</th>'));
    }
    table.append(row);

    var row1 = $('<tr></tr>');
    for (var i = 0;i < numPeople;i++){
        row1.append($('<td>' + startingSum + '</td>'));
    }
    table.append(row1);
}