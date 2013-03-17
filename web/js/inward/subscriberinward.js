function drawInwardTable(){

    $("#inwardTable").jqGrid({
            url:"inward?action=subscriberInward&subscriberNumber=" + $("#subscriberNumber").val(),
            datatype: 'xml',
            mtype: 'GET',
            width: '99%',
            height: 300,
            autowidth: true,
            forceFit: true,
            shrinkToFit: true,
            sortable: false,
            sortname: 'inwardNumber',
            loadonce: false,
            rownumbers: true,
            //scroll: true,
            scrollOffset: 20,
            emptyrecords: "No inwards to view",
            loadtext: "Loading...",
            colNames:['Inward No','Date','Purpose','Cheque No','Cheque Date','Amount','Receipt No.','Receipt Date','Currency','Ack Date','Chq Return','Completed','Valid','View/Edit'],
            colModel :[
                {name:'InwardNo', index:'inwardNumber', width:30, align:'center', xmlmap:'inwardNumber'},
                {name:'ReceivedDate', index:'inwardCreationDate', width:30, align:'center', xmlmap:'inwardCreationDate'},
                {name:'Purpose', index:'inwardPurpose', width:55, align:'center', xmlmap:'inwardPurpose'},
                {name:'chqno', index:'chqno', width:30, align:'center', xmlmap:'chqddNumber'},
                {name:'chqdt', index:'chqdt', width:40, align:'center', xmlmap:'chqDate'},
                {name:'amount', index:'amount', width:25, align:'center', xmlmap:'amount'},
                {name:'receiptNumber', index:'receiptNumber', width:30, align:'center', xmlmap:'receiptNumber'},
                {name:'receiptDate', index:'receiptDate', width:30, align:'center', xmlmap:'receiptDate'},
                {name:'currency', index:'currency', width:30, align:'center', xmlmap:'currency'},
                {name:'ackDate', index:'ackDate', width:30, align:'center', xmlmap:'ackDate'},
                {name:'chequeDDReturn', index:'chequeDDReturn', width:30, align:'center', xmlmap:'chequeDDReturn', formatter: "checkbox"},
                {name:'completed', index:'completed', width:30, align:'center', xmlmap:'completed', formatter: "checkbox"},
                {name:'valid', index:'valid', width:20, align:'center', xmlmap:'valid', formatter:'checkbox'},
                {name:'Action', index:'action', sortable: false, width:30, align:'center'}
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
                    var iscompleted = YesNo2Boolean(jQuery("#inwardTable").jqGrid('getCell', inwardId, 'completed'));
                    var valid = YesNo2Boolean(jQuery("#inwardTable").jqGrid('getCell', inwardId, 'valid'));
                    var can_edit = !iscompleted && valid;
                    action = "<a style='color:blue;' href='inward?action=view&inwardNumber=" + inwardId + "'>View</a>";
                    if(can_edit){
                        action += "<a style='color:blue;' href='inward?action=edit&inwardNumber=" + inwardId + "'>Edit</a>";
                    }

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
