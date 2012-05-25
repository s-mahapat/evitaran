<%--
    Document   : Generate and Print Mailing List
    Author     : Deepali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/missingissue/missingissue.css"/>
        <title>Generate and Print mailing List</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/missingissue/missingissue.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/common.js"%>"></script>
        <script type="text/javascript" src="js/jquery/grid.common.js"></script>


        <script type="text/javascript">
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                search();

             });

            $(function(){

                $("#msTable").jqGrid({
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
                    emptyrecords: "No Mailing List Found\Generated",
                    loadtext: "Loading...",
                    colNames:['id', 'journalCode', 'copies', 'issue', 'month', '`year`', 'startYear', 'startMonth', 'endYear', 'endMonth'],
                    colModel :[
                        {name:'id', index:'id', width:80, align:'center', xmlmap:'id'},
                        {name:'journalCode', index:'journalCode', width:80, align:'center', xmlmap:'journalCode'},
                        {name:'copies', index:'copies', width:80, align:'copies', xmlmap:'copies'},
                        {name:'issue', index:'issue', width:80, align:'center', xmlmap:'issue'},
                        {name:'month', index:'month', width:80, align:'center', xmlmap:'month'},
                        {name:'year', index:'year', width:80, align:'center', xmlmap:'year'},
                        {name:'startYear', index:'startYear', width:80, align:'center', xmlmap:'startYear'},
                        {name:'startMonth', index:'startMonth', width:80, align:'center', xmlmap:'startMonth'},
                        {name:'endYear', index:'endYear', width:80, align:'center', xmlmap:'endYear'},
                        {name:'endMonth', index:'endMonth', width:80, align:'center', xmlmap:'endMonth'},
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
                        var ids = jQuery("#msTable").jqGrid('getDataIDs');
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

            function search(){
                //check if search criteria is initial, raise alert else enable search for Records
                
                isPageLoaded = true;
                jQuery("#msTable").setGridParam({postData:
                    {
                        action                  : "getList"
                    }});

                jQuery("#msTable").setGridParam({ datatype: "xml" });
                jQuery("#msTable").trigger("clearGridData");
                jQuery("#msTable").trigger("reloadGrid");

                }
                
            function print(){
                
                $.get("<%=request.getContextPath()%>/generateml",
                        {year                   : $("#year").val(),
                        journalName             : $("#journalName").val(),
                        month                   : $("#month").val(),
                        mlCreationDate          : $("#mlCreationDate").val(),
                        issue                   : $("#issue").val(),
                        action                  : "print"
                    });
            
                
                isPageLoaded = true;
            }
                
                
            function loadIssues(){
                $("#issue").empty();
                $("#issue").text("");

                var newOption = new Option("Select", "value");
                $(newOption).html("Select");
                $("#issue").append(newOption);

                requestURL = "/JDS/CMasterData?md=getissues&mdvalue=" +  $("#journalName").val();
                jdsAppend(requestURL,"issueNumber","issue");
            }
            
        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/missingissue"%>" name="missingissueForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Missing Issue List</legend>
                        <jsp:useBean class="IAS.Bean.missingissue.missingissueFormBean" id="missingissueFormBean" scope="request"></jsp:useBean>
                            <fieldset class="subMainFieldSet">
                            <legend>Subscription Details</legend>

                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward Number:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="inwardNumber" id="inwardNumber" value="${missingissueFormBean.inwardNumber}"/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Number:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="1" readonly type="text" name="subscriberNumber" id="subscriberNumber" value="${missingissueFormBean.subscriberNumber}"/>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Name:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="subscriberName" id="subscriberName" value="${missingissueFormBean.subscriberName}"/>
                                    </span>
                                </div>                                
                            </div>
                            </fieldset>
                             
                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Search Result Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <fieldset class="subMainFieldSet">
                                <legend>Mailing List Table</legend>

                                <table class="datatable" id="msTable"></table>
                                <div id="pager"></div>
                            </fieldset>

                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Journal Actions Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>

                            <fieldset class="subMainFieldSet">
                                <div class="IASFormFieldDiv">
                                    <div id="printLabelBtnDiv">
                                        <input class="IASButton" TABINDEX="4" type="button" value="Print Label" id="btnPrintLabel" name="btnPrintLabel" onclick="printLabel()"/>
                                    </div>   
                                    <div id="printStickerBtnDiv">
                                        <input class="IASButton" TABINDEX="4" type="button" value="Print Sticker" id="btnPrintSticker" name="btnPrintSticker" onclick="printSticker()"/>
                                    </div>
                                    <div id="printNoCopyBtnDiv">
                                        <input class="IASButton" TABINDEX="4" type="button" value="No Copy" id="btnPrintLabel" name="btnPrintLabel" onclick="printLabel()"/>
                                    </div>   
                                    <div id="printSentMsgBtnDiv">
                                        <input class="IASButton" TABINDEX="4" type="button" value="Already Sent" id="btnPrintSticker" name="btnPrintSticker" onclick="printSticker()"/>
                                    </div>                                    
                                </div>
                            </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
