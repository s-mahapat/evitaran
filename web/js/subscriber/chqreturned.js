function drawChequeReturnTable(){
    $("#chqreturnTable").jqGrid({
            url:"subscriber?action=chqreturn&subscriberNumber=" + $("#subscriberNumber").val(),
            datatype: 'xml',
            mtype: 'GET',
            width: '100%',
            height: 300,
            autowidth: true,
            forceFit: true,
            sortable: true,
            sortname: '',
            loadonce: false,
            rownumbers: true,
            emptyrecords: "No Records to view",
            loadtext: "Loading...",
            colNames:['Cheque/DD Number','Cheque/DD Date','Amount','Return Reason','Return Date'],
            colModel :[
                {name:'chqNumber', index:'chqNumber', width:50, align:'center', xmlmap:'chqNumber'},
                {name:'chqDate', index:'chqDate', width:80, align:'center', xmlmap:'chqDate'},
                {name:'amount', index:'amount', width:40, align:'center', xmlmap:'amount'},
                {name:'returnReason', index:'returnReason', sortable: false, width:60, align:'center',xmlmap:'returnReason'},
                {name:'returnDate', index:'returnDate', sortable: false, width:60, align:'center',xmlmap:'returnDate'}
            ],
            xmlReader : {
                root: "results",
                row: "row",
                page: "results>page",
                total: "results>total",
                records : "results>records",
                repeatitems: false,
                id: "chqNumber"
            },
            pager: '#pager_chqreturn',
            rowNum:15,
            rowList:[15,30,50],
            viewrecords: true,
            gridview: true,
            loadError: function(xhr,status,error){
                alert("Failed getting data from server " + status);
            }
        });
}