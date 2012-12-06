function drawInwardTable(){

    $("#inwardTable").jqGrid({
            url:"inward?action=subscriberInward&subscriberNumber=" + $("#subscriberNumber").val(),
            datatype: 'xml',
            mtype: 'GET',
            width: '100%',
            height: 300,
            autowidth: true,
            forceFit: true,
            sortable: false,
            sortname: 'inwardNumber',
            loadonce: false,
            rownumbers: true,
            //scroll: true,
            //scrollOffset: 50,
            emptyrecords: "No inwards to view",
            loadtext: "Loading...",
            colNames:['Inward No','Received Date','Purpose','Cheque No','Amount','Currency','Ack Date','Chq/DD Return','Completed','View/Edit'],
            colModel :[
                {name:'InwardNo', index:'inwardNumber', width:40, align:'center', xmlmap:'inwardNumber'},
                {name:'ReceivedDate', index:'inwardCreationDate', width:50, align:'center', xmlmap:'inwardCreationDate'},
                {name:'Purpose', index:'inwardPurpose', width:80, align:'center', xmlmap:'inwardPurpose'},
                {name:'chqno', index:'chqno', width:20, align:'center', xmlmap:'chqddNumber'},
                {name:'amount', index:'amount', width:40, align:'center', xmlmap:'amount'},
                {name:'currency', index:'currency', width:40, align:'center', xmlmap:'currency'},
                {name:'ackDate', index:'ackDate', width:50, align:'center', xmlmap:'ackDate'},
                {name:'chequeDDReturn', index:'chequeDDReturn', width:40, align:'center', xmlmap:'chequeDDReturn', formatter: "checkbox"},
                {name:'completed', index:'completed', width:30, align:'center', xmlmap:'completed', formatter: "checkbox"},
                {name:'Action', index:'action', sortable: false, width:50, align:'center',formatter:'showlink'}
            ],
            xmlReader : {
                root: "results",
                row: "row",
                page: "results>page",
                total: "results>total",
                records : "results>records",
                repeatitems: false,
                id: "inwardNumber"
            },
            pager: '#pager',
            rowNum:15,
            rowList:[15,30,50],
            viewrecords: true,
            gridview: true,
            //caption: '&nbsp;',
            gridComplete: function() {
                var ids = jQuery("#inwardTable").jqGrid('getDataIDs');
                if(ids.length > 0){
                    $("#btnNext").removeAttr("disabled");
                }
                for (var i = 0; i < ids.length; i++) {
                    var inwardId = ids[i];
                    action = "<a style='color:blue;' href='inward?action=view&inwardNumber=" + inwardId + "'>View</a><a style='color:blue;' href='inward?action=edit&inwardNumber=" + inwardId + "'>Edit</a>";
                    jQuery("#inwardTable").jqGrid('setRowData', ids[i], { Action: action });
                }
            },
            beforeRequest: function(){
                return true;
            },
            loadError: function(xhr,status,error){
                alert("Failed getting data from server " + status);
            }

        });


}
