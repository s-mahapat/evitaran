<%--
    Document   : Journal Rate - Print
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/report/journalRates.css" />

        <title>Annual Rates for Journal</title>
        <script type="text/javascript">
            $(document).ready(function() {
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=subscriberType"%>","subscriberType","subscriberType");
                jQuery("#printReportBtn").attr("disabled",true);
            });
        </script>
        <script type="text/javascript">
            var isPageLoaded = false;

            $(function(){
                $("#datatable").jqGrid({
                    url:  "<%=request.getContextPath() + "/main?action=journalRates"%>",
                    datatype: 'xml',
                    type: 'GET',
                    width: '100%',
                    height: 300,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No records to view",
                    loadtext: "Loading...",
                    colNames: <jsp:getProperty name="subscriptionRatesFormBeanReport" property="colN"/>,
                    colModel: <jsp:getProperty name="subscriptionRatesFormBeanReport" property="colM"/>,
                    xmlReader: {
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
                    rowList:[15,30,50],
                    viewrecords: true,
                    gridview: true,
                    caption: '&#160;',
                    editurl:"<%=request.getContextPath() + "/main?action=journalRates"%>",
                    gridComplete: function() {
                        var ids = jQuery("#datatable").jqGrid('getDataIDs');
                        if(ids.length > 0){
                            $("#printReportBtn").button("enable");
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

            $(document).ready(function(){
                isPageLoaded = true;
                getRates();
            });

            function getRates(){
                jQuery("#datatable").setGridParam({postData:
                        {subscriberType             : $("#subscriberType").val(),
                        year                        : $("#year").val()
                        }
                    });
                jQuery("#datatable").setGridParam({ url: "<%=request.getContextPath() + "/reports?action=listRates"%>" });
                jQuery("#datatable").setGridParam({ datatype: "xml" });
                jQuery("#datatable").trigger("clearGridData");
                jQuery("#datatable").trigger("reloadGrid");
            }

            // called when the search button is clicked
            function reLoadPage(){
                if ($("#year").val() == 0) {
                    alert("Select Year");
                }
                else if ($("#subscriberType").val() == 0){
                    alert("Select Subscriber Type");
                }
                else {
                        isPageLoaded = true;
                        var x = "constructTableJournalRates";
                        $('#action').val(x);
                }
            }

            function print(){
                 var x = "printRates";
                 $('#action').val(x);
            }

        </script>

    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/reports?"%>" name="listRates">
                <div class="MainDiv">
                    <input type="hidden" name="action" id="action"/>
                    <fieldset class="MainFieldset">
                        <legend>List and Print Annual Rates for Journal</legend>
                        <jsp:useBean class="IAS.Bean.Reports.subscriptionRatesFormBeanReport" id="subscriptionRatesFormBeanReport" scope="request"></jsp:useBean>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>

                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Year</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBox" TABINDEX="2" name="year" id="year" >
                                            <option value="0">Select</option>
                                            <%
                                                if (subscriptionRatesFormBeanReport.getYear() != 0) {
                                                out.println("<option selected=\"selected\" value=\"" + subscriptionRatesFormBeanReport.getYear() + "\">" + subscriptionRatesFormBeanReport.getYear() + "</option>");
                                                }
                                            %>
                                        </select>
                                    </span>
                                </div>
                            </div>

                           <%-- Search Criteria Right div --%>
                            <div class="IASFormLeftDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Type</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBoxWide" TABINDEX="3" name="subscriberType" id="subscriberType">
                                            <option value="0">Select</option>
                                            <%
                                                if (subscriptionRatesFormBeanReport.getSubscriberType() != null && !(subscriptionRatesFormBeanReport.getSubscriberType()).isEmpty()) {
                                                out.println("<option selected=\"selected\" value=\"" + subscriptionRatesFormBeanReport.getSubscriberType() + "\">" + subscriptionRatesFormBeanReport.getSubscriberType() + "</option>");
                                                }
                                            %>
                                        </select>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <button class="IASButton SearchButton" type="submit" TABINDEX="3" onclick="reLoadPage()" value="Search"/>Search</button>
                                </div>
                            </div>

                        </fieldset>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                       <fieldset class="subMainFieldSet">
                            <legend>Result</legend>

                            <table class="datatable" id="datatable"></table>
                            <div id="pager"></div>
                        </fieldset>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Print Button Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" TABINDEX="4" type="submit" value="Print" id="printReportBtn" name="printReportBtn" onclick="print()"/>
                                </div>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>