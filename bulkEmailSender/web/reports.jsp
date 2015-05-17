<%--
    Document   : reports
    Created on : Dec 26, 2011, 2:37:21 PM
    Author     : aloko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%--
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
--%>

<html xmlns='http://www.w3.org/1999/xhtml' >
<head>
    <title>PicNet Table Filter Demo</title>
    <script src="js/jquery-ui-1.8.16/js/jquery-1.6.2.min.js"  type="text/javascript"></script>
    <script src="js/picnet/picnet.table.filter.min.js" type="text/javascript"></script>
    <link href="js/picnet/picnet.css" rel="stylesheet" type="text/css" />


    <script type='text/javascript'>
        $(document).ready(function() {
            //  Randomly Create Data Rows
            for (var i = 0; i < 50; i++) {
                var tr = $('<tr>' +
          '<td>Value' + Math.floor(Math.random() * 500) + '</td>' +
          '<td>' + Math.floor(Math.random() * 500) + ' </td>' +
          '<td>' + (Math.random() > 0.5 ? 'yes' : 'no') + '</td>' +
          '<td>' + (Math.random() <= 0.333 ? 'Item 1' : Math.random() > 0.5 ? 'Item 2' : 'Item 3') + '</td>' +
          '<td></td>' +
          '<td>' + parseInt(10 + Math.random() * 18) + '/' + parseInt(10 + Math.random() * 2) + '/2009</td>' +
          '<td></td>' +
          '</tr>');
                $('#demotable1 tbody').append(tr);
            }

      for (var i = 0; i < 50; i++) {
                var tr = $('<tr><td>Value(2) ' + Math.floor(Math.random() * 500) + '</td></tr>');
                $('#demotable2 tbody').append(tr);
            }

            // Initialise Plugin
            var options1 = {
                additionalFilterTriggers: [$('#onlyyes'), $('#onlyno'), $('#quickfind')],
                clearFiltersControls: [$('#cleanfilters')],
                matchingRow: function(state, tr, textTokens) {
                    if (!state || !state.id) { return true; }
          var child = tr.children('td:eq(2)');
          if (!child) return true;
          var val =  child.text();
          switch (state.id) {
            case 'onlyyes': return state.value !== true || val === 'yes';
            case 'onlyno': return state.value !== true || val === 'no';
            default: return true;
          }
                }
            };

            $('#demotable1').tableFilter(options1);

      var grid2 = $('#demotable2');
      var options2 = {
                filteringRows: function(filterStates) {
          grid2.addClass('filtering');
                },
        filteredRows: function(filterStates) {
          grid2.removeClass('filtering');
          setRowCountOnGrid2();
                }
            };
      function setRowCountOnGrid2() {
        var rowcount = grid2.find('tbody tr:not(:hidden)').length;
        $('#rowcount').text('(Rows ' + rowcount + ')');
      }

      grid2.tableFilter(options2); // No additional filters
      setRowCountOnGrid2();
        });
    </script>

</head>
<body>
<div class='wrapper'>


  <div class='content'>
    <h3>Additional Filters for Table 1</h3>
    Only Show Yes: <input type='checkbox' id='onlyyes'/>
    Only Show No: <input type='checkbox' id='onlyno'/>
         &nbsp;<input type='submit' value='Set Quick Find filter and refresh table' onclick="$('#quickfind').val('12'); $('#demotable1').tableFilterRefresh();"/>
    <br/>      <br/>
    Quick Find: <input type='text' id='quickfind'/>

    <a id='cleanfilters' href='#'>Clear Filters</a>
    <div class='clear'></div>
    <br/>
    <div class='column1'>
      <h3>Table 1</h3>
      <table id='demotable1'>
        <thead>
          <tr><th>Text Column 1</th><th>Number Column</th><th>Yes/No Column</th><th filter-type='ddl'>List Column</th><th filter='false'>No Filter</th><th>Date Column</th><th filter='false'>Empty</th></tr>

        </thead>
        <tbody>
        </tbody>
      </table>
    </div>

    <div class='column2'>
      <h3>Table 2 <span id='rowcount'></span></h3>
      <table id='demotable2'>
        <thead>

          <tr><th>Text Column 2</th></tr>
        </thead>
        <tbody>
        </tbody>
      </table>
    </div>
    <div class='clear'></div>
    <hr/>
  </div>
</div>
  </body>
</html>
