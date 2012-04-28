            var selectedInward = 0;
            var selectedSubscriberId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){

                $("#inwardTable").jqGrid({
                    url:"<%=request.getContextPath() + "/inward?action=subscriberInward"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    sortname: 'inwardNumber',
                    loadonce: false,
                    rownumbers: true,
                    scrollOffset: 20,
                    emptyrecords: "No inwards to view",
                    loadtext: "Loading...",
                    colNames:['Inward No','Received Date','City','Cheque#','Purpose','View/Edit'],
                    colModel :[
                        {name:'InwardNo', index:'inwardNumber', width:50, align:'center', xmlmap:'inwardNumber'},
                        {name:'ReceivedDate', index:'inwardCreationDate', width:80, align:'center', xmlmap:'inwardCreationDate'},
                        {name:'City', index:'city', width:80, align:'center', xmlmap:'city'},
                        {name:'Cheque', index:'chqddNumber', width:40, align:'center', xmlmap:'chqddNumber'},
                        {name:'Purpose', index:'inwardPurpose', width:80, align:'center', xmlmap:'inwardPurpose'},
                        {name:'Action', index:'action', sortable: false, width:80, align:'center',formatter:'showlink'}
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
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
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
                        return isPageLoaded;
                    },
                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server " + status);
                    }

                });

            });

            // called when the search button is clicked
            function searchInwards(){
                jQuery("#inwardTable").setGridParam({ datatype: "xml" });
                if(validateSearch() == true){
                    isPageLoaded = true;
                    jQuery("#inwardTable").setGridParam({postData:
                            {subscriberNumber           : $("#subscriberNumber").val()
                        }});
                    jQuery("#inwardTable").trigger("clearGridData");
                    jQuery("#inwardTable").trigger("reloadGrid");

                }

            }
