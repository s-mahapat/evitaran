<%--
    Document   : Generate and Print - Back Issue List
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>,
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/ml/generatebil.css"/>
        <title>Generate and Print Back Issue List</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/ml/generatebil.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/common.js"%>"></script>
        <script type="text/javascript" src="js/jquery/grid.common.js"></script>


        <script type="text/javascript">
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=month"%>","month","month");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=subscriberNumber"%>","subscriberNumber","subscriberNumber");

             });

            $(function(){

                $("#bilTable").jqGrid({
                    url:"<%=request.getContextPath()%>/generateml",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No Mailing List Found",
                    loadtext: "Loading...",
                    colNames:['Id','subscriberNumber','Journal Name','Month', 'Year', 'Issue','Print'],
                    colModel :[
                        {name:'id', index:'id', width:80, align:'center', xmlmap:'id'},
                        {name:'subscriberNumber', index:'subscriberNumber', width:80, align:'center', xmlmap:'subscriberNumber'},                       
                        {name:'journalName', index:'journalName', width:80, align:'center', xmlmap:'journalName'},
                        {name:'month', index:'month', width:80, align:'center', xmlmap:'month'},
                        {name:'year', index:'year', width:80, align:'center', xmlmap:'year'},
                        {name:'issue', index:'issue', width:80, align:'center', xmlmap:'issue'},
                        {name:'Action', index:'action', width:80, align:'center',formatter:'showlink'}                        
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
                    rowNum:15,
                    rowList:[15,30,45],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    editurl:"<%=request.getContextPath()%>/generateml?action=search",
                    gridComplete: function() {
                        var ids = jQuery("#bilTable").jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            action = "<a style='color:blue;' href='generateml?action=print&id=" + ids[i] + "'>Print</a>";
                            jQuery("#generateml").jqGrid('setRowData', ids[i], { Action: action });
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

            function generate(){
            
                if (($("#subscriberNumber").val() == 0) || ($("#selall:checked").val()) == 0 ){
                    alert("Select Subscriber Number or All pending Back isuses");
                }

                else {
                        isPageLoaded = true;
                        jQuery("#bilTable").setGridParam({postData:
                                {
                                subscriberNumber        : $("#subscriberNumber").val(),
                                selall                  : $("#selall:checked").length,
                                bilCreationDate          : $("#bilCreationDate").val(),
                                action                  : "generate"
                            }});
                        jQuery("#bilTable").setGridParam({ datatype: "xml" });
                        jQuery("#bilTable").trigger("clearGridData");
                        jQuery("#bilTable").trigger("reloadGrid");
                    }               
            }


            function search(){
                //check if search criteria is initial, raise alert else enable search for Records
                if (($("#subscriberNumber").val() == 0) || ($("#selall:checked").val()) == 0 ){
                    alert("Select Subscriber Number or All pending Back isuses");
                }
                else {
                        isPageLoaded = true;
                        jQuery("#bilTable").setGridParam({postData:
                                {subscriberNumber       : $("#subscriberNumber").val(),
                                year                    : $("#year").val(),                                
                                month                   : $("#month").val(),
                                bilCreationDate         : $("#bilCreationDate").val(),
                                action                  : "search"
                            }});

                        jQuery("#bilTable").setGridParam({ datatype: "xml" });
                        jQuery("#bilTable").trigger("clearGridData");
                        jQuery("#bilTable").trigger("reloadGrid");

                    }
                }
                
            function getChecked(){
                if (document.getElementById("selall").value == 1 ){
                    document.getElementById("selall").value = 0;
                }else {
                    document.getElementById("selall").value = 1;
                }
            }                
                           
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/generateml"%>" name="mlForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Generate and Print Back Issue List</legend>
                        <jsp:useBean class="IAS.Bean.MailingList.mlFormBean" id="mlFormBean" scope="request"></jsp:useBean>
                            <fieldset class="subMainFieldSet">
                                <legend>Actions - Search / Generate Back Issue list</legend>
                                    <div class="IASFormFieldDiv">
                                        <div id="searchBtnDiv">
                                             <input class="IASButton" TABINDEX="5" type="button" value="Display/ Print Back Issue List" id="btnSearchEnable" name="btnSearchEnable" onclick="search()"/>
                                        </div>                                          
                                        <div id="addBtnDiv">
                                             <input class="IASButton" TABINDEX="6" type="button" value="Generate/ Print Back Issue List" id="btnGenerateEnable" name="btnGenerateEnable" onclick="generate()"/>
                                        </div>   
                                     </div>
                            </fieldset>                        
                            <fieldset class="subMainFieldSet">
                                <legend>Selection Criteria</legend>
                                    <%-- Search Criteria left div --%>
                                    <div class="IASFormLeftDiv">
                                        <div class="IASFormFieldDiv">
                                            <div class="IASFormFieldDiv">
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Subscriber Number</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                    <select class="IASComboBox" TABINDEX="1" name="subscriberNumber" id="subscriberNumber">
                                                        <option value="0">Select</option>
                                                    </select>
                                                </span>
                                            </div>
                                            <div class="IASFormFieldDiv">                                                
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Year:</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                <select class="IASComboBox" TABINDEX="3" name="year" id="year">
                                                        <option value="0">Select</option>
                                                    </select>
                                                </span>
                                            </div>
                                            <div class="IASFormFieldDiv">                                                
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Month:</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">   
                                                <select class="IASComboBox" TABINDEX="4" name="month" id="month">
                                                        <option value="0">Select</option>
                                                    </select>
                                                </span>
                                            </div>                                              
                                        </div>                                  
                                    </div>
                                    <%-- Search Criteria right div --%>
                                    <div class="IASFormRightDiv">
                                        <div class="IASFormFieldDiv">
                                            <div class="IASFormFieldDiv">
                                                <span class="IASFormDivSpanLabel">
                                                    <label>All Pending Back Issues</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                    <input class="IASCheckBox" TABINDEX="2" type="checkbox" name="selall" id="selall" onclick="getChecked()"/>
                                                </span>
                                            </div>
                                            <div class="IASFormFieldDiv">
                                                <span class="IASFormDivSpanLabel">
                                                    <label>Creation Date:</label>
                                                </span>
                                                <span class="IASFormDivSpanInputBox">
                                                    <input class="IASDateTextBox" TABINDEX="-1" readonly type="text" name="bilCreationDate" id="bilCreationDate" value="<jsp:getProperty name="mlFormBean" property="mlCreationDate"/>"
                                                </span>
                                            </div>                                                  
                                        </div>
                                    </div>
                            </fieldset>
                            <fieldset class="subMainFieldSet">
                                <legend>Actions - Search / Generate</legend>
                                    <div class="IASFormFieldDiv">
                                        <div id="searchBtnDiv">
                                             <input class="IASButton" TABINDEX="5" type="button" value="Display" id="btnSearch" name="btnSearch" onclick="search()"/>
                                        </div>                                          
                                        <div id="addBtnDiv">
                                             <input class="IASButton" TABINDEX="6" type="button" value="Generate" id="btnGenerate" name="btnGenerate" onclick="generate()"/>
                                        </div>   
                                     </div>
                            </fieldset>                              
                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Search Result Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <fieldset class="subMainFieldSet">
                                <legend>Mailing List Table</legend>

                                <table class="datatable" id="bilTable"></table>
                                <div id="pager"></div>
                            </fieldset>

                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Journal Actions Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>

                            <fieldset class="subMainFieldSet">
                                <div class="IASFormFieldDiv">
                                    <div id="cancelBtnDiv">
                                        <input class="IASButton" TABINDEX="4" type="reset" value="Reset"/>
                                    </div>
                                </div>
                            </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
