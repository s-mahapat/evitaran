<%--
    Document   : Subscription Figure for Journal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/circulationFigures.css" />
        <title>Subscription Figures</title>
        <script type="text/javascript">
            $(document).ready(function() {
                <%--jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");--%>
                $("#printReportBtn").button("disable");
            });
        </script>

        <script>
            var isPageLoaded = false;

            $(function(){

                      $("#subscriptionFigTable").jqGrid({
                        url:"<%=request.getContextPath() + "/reports?action=subscriptionFiguresLegacy"%>",
                        datatype: 'xml',
                        mtype: 'GET',
                        width: '100%',
                        height: Constants.jqgrid.HEIGHT,
                        autowidth: true,
                        forceFit: true,
                        sortable: true,
                        loadonce: true,
                        rownumbers: true,
                        emptyrecords: "No records to view",
                        loadtext: "Loading...",                       
                        colNames:['Journal', 'Inst India', 'Inst Abr', 'Indv Ind', 'Indv Abr', 'SUB COPIES', 'COMP'],
                        colModel :[
                            {name:'journalCode', index:'journalCode', width:80, align:'center', xmlmap:'journalCode'},
                            {name:'Inst_I', index:'Inst_I', width:80, align:'center', xmlmap:'Inst_I'},
                            {name:'Inst_A', index:'Inst_A', width:80, align:'center', xmlmap:'Inst_A'},
                            {name:'IND_I', index:'IND_I', width:80, align:'center', xmlmap:'IND_I'},
                            {name:'IND_A', index:'IND_A', width:80, align:'center', xmlmap:'IND_A'},
                            {name:'SUB_COPIES', index:'SUB_COPIES', width:80, align:'center', xmlmap:'SUB_COPIES'},
                            {name:'COMP', index:'COMP', width:80, align:'center', xmlmap:'COMP'},
                        ],                        
                        xmlReader : {
                          root: "results",
                          row: "row",
                          page: "results>page",
                          total: "results>total",
                          records : "results>records",
                          repeatitems: false,
                          id: "journal_id"
                       },
                        pager: '#pager',
                        rowNum:15,
                        rowList:[15,30,50],
                        viewrecords: true,
                        gridview: true,
                        caption: '&nbsp;',
                        gridComplete: function() {
                            var ids = jQuery("#subscriptionFigTable").jqGrid('getDataIDs');
                            if(ids.length > 0){
                                $("#printReportBtn").button("enable");
                            }
                        },
                        beforeRequest: function(){
                          return isPageLoaded;
                        },
                        loadError: function(xhr,status,error){
                            alert("Failed getting data from server: " + status);
                        }
                    });
            });

            function getReport(){

                    isPageLoaded = true;
                    jQuery("#subscriptionFigTable").setGridParam({postData:
                            {action         : "subscriptionFiguresLegacy",
                            year            : $("#year").val()
                        }});
                    jQuery("#subscriptionFigTable").setGridParam({ datatype: "xml" });
                    jQuery("#subscriptionFigTable").trigger("clearGridData");
                    jQuery("#subscriptionFigTable").trigger("reloadGrid");

            }

        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <jsp:useBean class="IAS.Bean.Reports.subscriptionFiguresFormBeanReport" id="subscriptionFiguresFormBeanReport" scope="request"></jsp:useBean>
            <form method="post" action="<%=request.getContextPath() + "/reports?action=printSubscriptionFiguresLegacy"%>" name="subscriptionFigures">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Subscription Figures</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>
                            <div class="IASFormLeftDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Year</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBoxSmallMandatory allusers" TABINDEX="1" name="year" id="year">
                                            <%--<option value="0">Select</option>--%>
                                            <%
                                                for (int j = 1990; j <= 2050; j++) {
                                                    out.println("<option value =\"" + j + "\">" + j + "</option>");
                                                }
                                            %>
                                        </select>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormRightDiv">

                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton allusers" TABINDEX="2" type="button" onclick="getReport()" value="Get Report"/>
                                </div>

                                <div id="resetBtnDiv">
                                    <input class="IASButton allusers" TABINDEX="3" type="reset" value="Reset"/>
                                </div>
                            </div>

                        </fieldset>


                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Result</legend>

                            <table class="subscriptionFigTable" id="subscriptionFigTable"></table>
                            <div id="pager"></div>
                        </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Print Action Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>


                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <%--<input class="IASButton" type="button" value="Print" onclick="javascript:window.print();"/>--%>
                                    <input class="IASButton allusers" type="submit" TABINDEX="4" value="Print" disabled id="printReportBtn"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>