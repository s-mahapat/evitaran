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

            $(function(){

                $("#msTable").jqGrid({
                    url:"<%=request.getContextPath()%>/missingissue",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No Mailing List Found or Generated",
                    loadtext: "Loading...",
                    colNames:['Id', 'Subscription Detail id', 'Journal Group', 'Journal Code', 'Journal Name', 'Sub Copies',
                                'Start Year', 'Start Month', 'End Month', 'End Year', 'Month', 'Year', 'Missing Copies'],
                    colModel :[
                        {name:'id', index:'id', width:80, align:'center', xmlmap:'id'},
                        {name:'subscriptiondetailsId', index:'subscriptoindetailsId', width:2, align:'center', xmlmap:'subscriptiondetailsId'},
                        {name:'journalGroupName', index:'journalGroupName', width:80, align:'center', xmlmap:'journalGroupName'},
                        {name:'journalCode', index:'journalCode', width:80, align:'center', xmlmap:'journalCode'},
                        {name:'journalName', index:'journalName', width:80, align:'center', xmlmap:'journalName'},
                        {name:'copies', index:'copies', width:80, align:'center', xmlmap:'copies'},
                        {name:'startYear', index:'startYear', width:80, align:'center', xmlmap:'startYear'},
                        {name:'startMonth', index:'startMonth', width:80, align:'center', xmlmap:'startMonth'},
                        {name:'endMonth', index:'endMonth', width:80, align:'center', xmlmap:'endMonth'},
                        {name:'endYear', index:'endYear', width:80, align:'center', xmlmap:'endYear'},
                        {name:'month', index:'month', width:80, align:'center', xmlmap:'month'},
                        {name:'year', index:'year', width:80, align:'center', xmlmap:'year'},
                        {name:'missingCopies', index:'missingCopies', width:80, align:'center', xmlmap:'missingCopies'},
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
                    editurl:"<%=request.getContextPath()%>/missingissue",
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

            $(document).ready(function(){
                search();
             });

            function search(){
                //check if search criteria is initial, raise alert else enable search for Records

                isPageLoaded = true;
                jQuery("#msTable").setGridParam({postData:
                    {
                        miId                   : $("#miId").val(),
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



        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/missingissue?"%>" name="missingissueForm">
                <input type="hidden" name="action" id="action"/>
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Missing Issue List</legend>
                        <jsp:useBean class="IAS.Bean.missingissue.missingissueFormBean" id="missingissueFormBean" scope="request"></jsp:useBean>
                            <fieldset class="subMainFieldSet">
                                <legend>Subscription Details</legend>

                                <div class="IASFormLeftDiv">
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Missing Issue Id:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="miId" id="miId" value="${missingissueFormBean.miId}"/>
                                        </span>
                                    </div>
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Inward Number:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="inwardNumber" id="inwardNumber" value="${missingissueFormBean.inwardNumber}"/>
                                        </span>
                                    </div>

                                </div>

                                <div class="IASFormRightDiv">
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Subscriber Number:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="subscriberNumber" id="subscriberNumber" value="${missingissueFormBean.subscriberNumber}"/>
                                        </span>
                                    </div>
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Subscriber Name:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASDisabledTextBoxWide" TABINDEX="-1" readonly type="text" name="subscriberName" id="subscriberName" value="${missingissueFormBean.subscriberName}"/>
                                        </span>
                                    </div>
                                </div>
                            </fieldset>
                            <fieldset class="subMainFieldSet">
                                <legend>Address Details</legend>
                                <div class="IASFormLeftDiv">
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Address:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASDisabledTextBoxWide" TABINDEX="-1" readonly type="text" name="subscriberAddress" id="subscriberAddress" value="${missingissueFormBean.subscriberAddress}"/>
                                        </span>
                                    </div>
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>City:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASDisabledTextBoxWide" TABINDEX="-1" readonly type="text" name="city" id="city" value="${missingissueFormBean.city}"/>
                                        </span>
                                    </div>
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>District:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASDisabledTextBoxWide" TABINDEX="-1" readonly type="text" name="district" id="district" value="${missingissueFormBean.district}"/>
                                        </span>
                                    </div>
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>State:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASDisabledTextBoxWide" TABINDEX="-1" readonly type="text" name="state" id="state" value="${missingissueFormBean.state}"/>
                                        </span>
                                    </div>
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Country:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASDisabledTextBoxWide" TABINDEX="-1" readonly type="text" name="country" id="country" value="${missingissueFormBean.country}"/>
                                        </span>
                                    </div>
                                </div>

                                <div class="IASFormRightDiv">
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Pin Code:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASDisabledTextBoxWide" TABINDEX="-1" readonly type="text" name="pincode" id="pincode" value="${missingissueFormBean.pincode}"/>
                                        </span>
                                    </div>
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Department:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASDisabledTextBoxWide" TABINDEX="-1" readonly type="text" name="department" id="department" value="${missingissueFormBean.department}"/>
                                        </span>
                                    </div>
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Institution:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASDisabledTextBoxWide" TABINDEX="-1" readonly type="text" name="institution" id="institution" value="${missingissueFormBean.institution}"/>
                                        </span>
                                    </div>
                                    <div class="IASFormFieldDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>email:</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <input class="IASDisabledTextBoxWide" TABINDEX="-1" readonly type="text" name="email" id="email" value="${missingissueFormBean.email}"/>
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
                            <%-- Print Option Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <fieldset class="subMainFieldSet">
                                <legend>Generate/ Print Mailing List</legend>

                                <div class="IASFormFieldDiv">
                                    <div id="mlOptionDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Print Option</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <select class="IASComboBoxMandatory" TABINDEX="1" name="printOption" id="printOption">
                                                <option value ="LABEL">Label</option>
                                                <option value ="STICKER">Sticker</option>
                                            </select>
                                        </span>
                                    </div>
                                    <div id="gMiBtnDiv">
                                        <input class="IASButton" TABINDEX="2" type="button" value="Generate Mailing List" id="btngMi" name="btngMi" onclick="gMiList()"/>
                                    </div>
                                    <div id="reprintBtnDiv">
                                        <input class="IASButton" TABINDEX="3" type="button" value="Re-print Mailing List" id="btnReprint" name="btnReprint" onclick="reprint()"/>
                                    </div>
                                </div>

                            </fieldset>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Journal Actions Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>

                            <fieldset class="subMainFieldSet">
                                <div class="IASFormFieldDiv">
                                    <div id ="replyOptionDiv">
                                        <span class="IASFormDivSpanLabel">
                                            <label>Reply Option</label>
                                        </span>
                                        <span class="IASFormDivSpanInputBox">
                                            <select class="IASComboBoxMandatory" TABINDEX="4" name="replyOption" id="replyOption">
                                                <option value ="Print">Print</option>
                                                <option value ="EMail">EMail</option>
                                            </select>
                                        </span>
                                    </div>

                                <div id="noCopyBtnDiv">
                                    <input class="IASButton" TABINDEX="5" type="button" value="No Copy" id="btnNoCopy" name="btnNoCopy" onclick="noCopies()"/>
                                </div>
                                <div id="sentMsgBtnDiv">
                                    <input class="IASButton" TABINDEX="6" type="button" value="Already Sent" id="btnSentMsg" name="btnSentMsg" onclick="alreadySent()"/>
                                </div>
                                </div>


                            </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>
