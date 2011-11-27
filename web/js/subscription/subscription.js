function setSubmitButtonValue(button,value){
    button.value = value;
}

function listSubscription(mode){
    
    $(function(){
        $("#subscriptionList").jqGrid({
            url:'/JDS/jsp/subscription/subscriptionlistXML.jsp',
            datatype: 'xml',
            mtype: 'GET',
            width: '100%',
            autowidth: true,
            forceFit: true,
            sortable: true,
            loadonce: true,
            rownumbers: true,
            emptyrecords: "No subscription to view",
            loadtext: "Loading...",
            colNames:['Journal Code','Journal Name','#Copies', 'Start Year','#Years','Delete Journal'],
            colModel :[
            {
                name:'Journal Code', 
                index:'journal_code', 
                width:20, 
                align:'center', 
                xmlmap:'journal_code'
            },

            {
                name:'Journal Name', 
                index:'journal_name', 
                width:30, 
                align:'center', 
                xmlmap:'journal_name'
            },

            {
                name:'#Copies', 
                index:'num_copies', 
                width:60, 
                align:'center', 
                xmlmap:'num_copies'
            },

            {
                name:'Start Year', 
                index:'start_year', 
                width:50, 
                align:'center', 
                sortable: true, 
                sorttype: 'int',
                xmlmap:'start_year'
            },

            {
                name:'#Years', 
                index:'num_years', 
                width:50, 
                align:'center', 
                sortable:false, 
                xmlmap:'num_years'
            },

            {
                name:'Delete Journal', 
                index:'action', 
                width:50, 
                align:'center'
            },
            ],
            xmlReader : {
                root: "result",
                row: "subscriptionlist",
                page: "subscriptionlistXML>page",
                total: "subscriptionlist>total",
                records : "subscriptionlist>records",
                repeatitems: false,
                id: "id"
            },
            pager: '#pager',
            rowNum:10,
            rowList:[10,20,30],
            viewrecords: true,
            gridview: true,
            caption: '&nbsp;',
                        
            gridComplete: function() {
                var ids = jQuery("#subscriptionList").jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var cl = ids[i];
                    action = "<input type='Button' name='deleteJournal' value=\"Delete\" onclick=''/>";
                    jQuery("#subscriptionList").jqGrid('setRowData', ids[i], {
                        "Delete Journal": action
                    });
                }
                
                //To hide the column - Delete 
                var myGrid = $('#subscriptionList');
                var colPos = 6;
                var cm = myGrid.getGridParam("colModel");
                
                if (mode=="Display") {
                    myGrid.jqGrid('hideCol', cm[colPos].name);
                }
            }
        });
        

    });
   
}