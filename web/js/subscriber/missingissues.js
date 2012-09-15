function drawMissingIssuesTable(){
    $("#missing_issuesTable").jqGrid({
            url:"subscriber?action=mi&sid=" + $("#subscriberid").val(),
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
            emptyrecords: "No Missing Issues to view",
            loadtext: "Loading...",
            colNames:['Inward No','Journal','Month','Year','Missing Copies','Action','Sent On'],
            colModel :[
                {name:'inwardNumber', index:'inwardNumber', width:50, align:'center', xmlmap:'inwardNumber'},
                {name:'journalName', index:'journalName', width:80, align:'center', xmlmap:'journalName'},
                {name:'month', index:'month', width:40, align:'center', xmlmap:'month', formatter: monthNumberToName},
                {name:'year', index:'year', sortable: false, width:60, align:'center',xmlmap:'year'},
                {name:'missingcopies', index:'missingcopies', sortable: false, width:60, align:'center',xmlmap:'missingcopies'},
                {name:'action', index:'action', sortable: false, width:60, align:'center',xmlmap:'action'},
                {name:'senton', index:'senton', sortable: false, width:60, align:'center',xmlmap:'senton'}
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
            pager: '#pager_missing_issues',
            rowNum:15,
            rowList:[15,30,50],
            viewrecords: true,
            gridview: true,                   
            loadError: function(xhr,status,error){
                alert("Failed getting data from server " + status);
            }
        });
}