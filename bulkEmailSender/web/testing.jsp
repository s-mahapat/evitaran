<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>My First Grid</title>

<link rel="stylesheet" type="text/css" media="screen" href="js/jquery-ui-1.8.16/css/ui-lightness/jquery-ui-1.8.16.custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="js/jqGrid-4.3.1/css/ui.jqgrid.css" />

<script src="js/jquery-ui-1.8.16/js/jquery-1.6.2.min.js"  type="text/javascript"></script>
<script src="js/jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="js/jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<script type="text/javascript">
$(function(){
    $("#list").jqGrid({
    //url:'example.php',
    url: '<%=request.getContextPath()%>/generateReport?q=1&action=fetchData',
    datatype: 'xml',
    mtype: 'GET',
    width: '100%',
    height: 240,
    autowidth: true,
    forceFit: true,
    sortable: true,
    loadonce: false,
    rownumbers: true,
    emptyrecords: "No records to view",
    loadtext: "Loading...",
    colNames:['id','Email ID','Subject', 'Mail Text','Status','Date'],
    colModel :[
      {name:'id', index:'id', width:15, align:'center', xmlmap:'id'},
      {name:'emailid', index:'emailid', width:55, align:'center', xmlmap:'emailid'},
      {name:'subject', index:'subject', width:50, align:'center', xmlmap:'subject'},
      {name:'messageText', index:'messageText', width:110, align:'center', xmlmap:'messageText'},
      {name:'status', index:'status', width:15, align:'center', xmlmap:'status'},
      {name:'date', index:'date', width:25, align:'center', xmlmap:'date'}
    ],
   xmlReader : {
        root: "results",
        row: "row",
        page: "results>page",
        total: "results>total",
        records : "results>records",
        repeatitems: false,
        id: "id"
    },
    pager: '#pager',
    pginput: false,
    rowNum:5,
    rowList:[5,10,15],
    sortorder: "asc",
    sortname: 'id',
    viewrecords: true,
    gridview: true,
    caption: '&nbsp;',
    loadError: function(xhr,status,error){
        alert("Failed getting data from server " + status);
    }
    });
});
</script>

</head>
<body>
<table id="list"><tr><td/></tr></table>
<div id="pager"></div>
</body>
</html>