<%--
    Document   : Print Order
--%>
        <script type="text/javascript">
           // var selectedJournal = 0;
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                searchPrintOrder();
            });

            $(function(){

                $("#printOrderTable").jqGrid({
                    url:"<%=request.getContextPath()%>/printOrder?action=getPrintOrder&year=<%=request.getParameter("selectedYear")%>",
                    //data: {selectedYear: 2010 },
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: false,
                    rownumbers: true,
                    emptyrecords: "No Print Order for selected Year",
                    loadtext: "Loading...",
                    colNames:['Print Order Id','Journal Code','Journal Name','year','Isses per Yer', 'Print Order', 'Annual Print Order'],
                    colModel :[
                        {name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        {name:'journalCode', index:'journalCode', width:80, align:'center', xmlmap:'journalCode'},
                        {name:'journalName', index:'journalName', width:80, align:'center', xmlmap:'journalName'},
                        {name:'issues', index:'issues', width:80, align:'center', xmlmap:'issues'},
                        {name:'year', index:'year', width:80, align:'center', xmlmap:'year'},
                        {name:'printOrder', index:'printOrder', width:80, align:'center',formatter:'printOrder'},
                        {name:'annualPrintorder', index:'annualPrintorder', width:80, align:'center',formatter:'annualPrintOrder'}
                    ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        page: "printorder>page",
                        total: "printOrder>total",
                        records : "printOrder>records",
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
                        var ids = jQuery("#printOrderTable").jqGrid('getDataIDs');

                        for (var i = 0; i < ids.length; i++) {
                            action = "<a style='color:blue;' href='printOrder?action=edit&id=" + ids[i] + "'>Edit</a>";
                            jQuery("#printOrderTable").jqGrid('setRowData', ids[i], { Action: action });
                        }
                    },
                    beforeRequest: function(){
                        return isPageLoaded;
                    },
                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server" + status);
                    }

                });

            });

            function getQueryParameter ( parameterName )
            {
                var queryString = window.top.location.search.substring(1);
                //alert('String: ' + queryString + 'search for: ' + parameterName);
                var parameterName = parameterName + "=";
                if ( queryString.length > 0 )
                {
                    begin = queryString.indexOf ( parameterName );
                    if ( begin != -1 )
                    {
                        begin += parameterName.length;
                        end = queryString.indexOf ( "&" , begin );
                        if ( end == -1 )
                        {
                            end = queryString.length
                        }
                        return unescape ( queryString.substring ( begin, end ) );
                    }
                }
                return "null";
            }

            // called when the search button is clicked
            function searchPrintOrder(){
                //var selectedYear = getQueryParameter("selectedYear");
                //alert('year: ' + selectedYear);

                //var url = location.search;
                //alert('year: ' + selectedYear + ' url: ' + url);
                if(validatePrintOrder() == true)
                    {
                        isPageLoaded = true;

                        jQuery("#printOrderTable").setGridParam({postData:
                                {//year       : $("#year1").val()
                                //selectedYear       : $request.getParameter("selectedYear")
                                //selectedYear    : $("#selectedYear").val()
                                //selectedYear    :$.query.get('selectedYear')
                                //selectedYear    :$("#selectedYear").val()
                                //selectedYear    :"2010"
                                url               :'<%=request.getContextPath() + "/printOrder?action=getPrintOrder1"%>'
                            }});

                        //jQuery("#printOrderTable").setGridParam({selectedYear: "selectedYear"});
                        //jQuery("#printOrderTable").setGridParam({url: "<%=request.getContextPath() + "/printOrder?action=getPrintOrder1"%>"});
                        //alert('year: ' + selectedYear);
                        jQuery("#printOrderTable").setGridParam({ datatype: "xml" });
                        jQuery("#printOrderTable").trigger("clearGridData");
                        jQuery("#printOrderTable").trigger("reloadGrid");
                    }
                }


            // draw the date picker.
            //jQueryDatePicker("from","to");

        </script>

    <%-----------------------------------------------------------------------------------------------------%>
    <%-- Search Result Field Set --%>
    <%-----------------------------------------------------------------------------------------------------%>
    <fieldset class="subMainFieldSet">
        <legend>Search Result</legend>

        <table class="datatable" id="printOrderTable"></table>
        <div id="pager"></div>
    </fieldset>


    <%-----------------------------------------------------------------------------------------------------%>
    <%-- Journal Actions Field Set --%>
    <%-----------------------------------------------------------------------------------------------------%>

    <fieldset class="subMainFieldSet">
        <div class="IASFormFieldDiv">
            <input type="hidden" name="selectedYear" id="selectedYear" value="<jsp:getProperty name="printOrderFormBean" property="selectedYear"/>"/>
            <input type="hidden" name="action" id="action"/>
            <div id="saveBtnDiv">
                <input onclick="setActionValue('save')"  class="IASButton" TABINDEX="8" type="submit" value="Save" id="btnSave" name="btnSubmitAction"/>
            </div>
            <div id="editBtnDiv">
                <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="9" type="submit" value="Edit" id="btnEdit" name="btnSubmitAction"/>
            </div>

        </div>
    </fieldset>
