<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="IAS.Bean.Inward.inwardFormBean" id="inwardFormBean" scope="request"></jsp:useBean>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <jsp:include page="../templates/style.jsp"></jsp:include>

        <title>Process Agent Inward</title>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/inward/inward.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/agent/agentProc.js"%>"></script>
        <script type="text/javascript">
            var context = "<%=request.getContextPath()%>";
            $(document).ready(function() {
                resetSubscriberFields(); // Subscriber Fields should be reset during load of the page(Even after creating the subscriptions)
                drawResultsTable();
                $("#divAgentXLUpload").hide();
                $("#divsubscriberdtlsbtn").hide();
                $("#fieldsetsubscriberdtlsbtn").hide();

                //Handle fields of subscriber details
                hideSubsciberFields();
                makeReadOnlySubscriberFields();

                // On enter functionality after entering the subscriber number
                $("#subscriberId").bind("keypress", function(e) {
                    if (e.keyCode == 13) {
                        ValidateSubscriber();
                        return false;
                    }
                });

                //This is required to be loaded to get the data on enter
                $("#subscriberName").focus();
                jdsAppend("CMasterData?md=city","city","city");
                jdsAppend("CMasterData?md=country","country","country");
                jdsAppend("CMasterData?md=state","state","state");
                jdsAppend("CMasterData?md=district","district","district");
                jdsAppend("CMasterData?md=agent","agentName","agent");
                jdsAppend("CMasterData?md=sub_type","subtype","subtype");

            });

            $(function(){
                $("#btnManualCreation")
                .click(function(){
                    $("#indicatorUploadValidate").val("false");
                    $("#divSearchSubscriber").show();
                    $("#divAgentXLUpload").hide();
                    $("#divsubscriberdtlsbtn").hide();
                    $("#fieldsetsubscriberdtlsbtn").hide();
                    $("#divManualProc").show();
                });
            });
            $(function(){
                $("#btnAgentXLUpload")
                .click(function(){
                    agentXLUpload();
                    $("#indicatorUploadValidate").val("true");
                    $("#divSearchSubscriber").hide();
                    $("#divManualProc").hide();
                    $("#divAgentXLUpload").show();
                });
            });
            $(function() {
                $( "#btnSearchSubscriber" )
                .button({ icons: { primary: "ui-icon-circle-zoomin"} })
                .click(function() {
                    validateSearchSubscriber();
                    return false;
                });
            });

            $(function() {
                $( "#btnCreateSubscriber" )
                .click(function() {
                    $("#createAgntSubscription").val("true");
                    $("#processInwardForm").submit();
                });
            });

            $(function(){
                $("#btnCreateSubscription")
                .click(function() {
                    $("#subscriberNumber").val($("#subscriberId").val());
                    $("#createAgntSubscription").val("true");
                    $("#processInwardForm").submit();
                });
            });

            $(function(){
                $("#btnCompleteInward")
                .click(function() {
                    $("#completeInward").val("true");
                    $("#processInwardForm").submit();
                });
            });

            function drawResultsTable(){
                //console.log(xml);
                $("#resultTable").jqGrid({
                    url: context + '/main2/agent/agentsubscription/' + $("#inwardNumber").val(),
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: Constants.jqgrid.HEIGHT,
                    autowidth: true,
                    viewrecords: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No records to view",
                    loadtext: "Loading...",
                    colNames:['Subscriber Number', 'Subscription Number'],
                    colModel :[
                        {name:'Subscriber Number', index:'subscriberNumber', align:'center', xmlmap:'subscriberNumber', formatter: linktosubscriber},
                        {name:'Subscription Number', index:'subscriptionNumber', align:'center', xmlmap:'subscriptionNumber'}
                    ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        repeatitems: false,
                        id: "subscriptionNumber"
                    },
                    gridComplete: function() {
                        // enable the save button only when a subscription gets
                        // added
                        var ids = jQuery("#resultTable").jqGrid('getDataIDs');
                        if(ids.length > 0){
                            $("#btnCompleteInward").button("enable");
                        }
                    },
                    pager: '#pager',
                    rowNum:10,
                    rowList:[10,20,30],
                    gridview: true,
                    caption: '&nbsp;',

                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server" + status);
                    }
                });
            }
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <%@include file="../fileupload/fileupload.jsp"%>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/inward/inward.css"%>" />
        <div id="bodyContainer">
            <form method="post" action="inward?action=processinward" name="processInwardForm" id="processInwardForm">
                <input type="hidden" id="indicatorUploadValidate" name ="indicatorUploadValidate" value=""/>
                <input type="hidden" id="inwardNumber" name ="inwardNumber" value="${inwardFormBean.inwardNumber}"/>
                <input type="hidden" id="subscriberNumber" name ="subscriberNumber" value=""/>
                <input type="hidden" id="createAgntSubscription" name ="createAgntSubscription" value=""/>
                <input type="hidden" id="completeInward" name ="completeInward" value=""/>
            </form>
            <div class="MainDiv">
                <fieldset class="MainFieldset">
                    <legend>Process Agent Inward</legend>
                    <fieldset class="subMainFieldSet">
                        <div class="IASFormFieldDiv">
                            <div class="IASFormLeftDiv">
                                <div class="singleActionBtnDiv">
                                    <U><text style="font-size: ">Select one option:</text></U>
                                    <label style="font-size: small; margin-left: 10px;" class="IASLabelOnly" for="btnManualCreation">Manual Creation:</label>
                                    <input class="IASRadioButton" CHECKED TABINDEX="1" type="radio" value="ManualCreation" id="btnManualCreation" name="btnAgentProc"/>
                                    <label style="font-size: small; margin-left: 10px;" class="IASLabelOnly" for="btnAgentXLUpload">Excel Upload:</label>
                                    <input class="IASRadioButton" TABINDEX="2" type="radio" value="MassCreation" id="btnAgentXLUpload" name="btnAgentProc"/>
                                </div>
                            </div>
                            <div class="IASFormRightDiv">
                                <label style="font-weight: bold">Inward Number:</label>
                                <label><a href="inward?action=view&inwardNumber=${inwardFormBean.inwardNumber}">${inwardFormBean.inwardNumber}</a></label>
                                <label style="font-weight: bold; margin-left: 20px;">Agent Name:</label>
                                <label>${inwardFormBean.agentName}</label>
                            </div>
                        </div>
                    </fieldset>
                </fieldset>


                <fieldset class="subMainFieldSet" id="divSearchSubscriber">
                    <legend>Add subscriber and subscription</legend>
                    <div>
                        <div class="IASFormLeftDiv">
                            <span class="IASFormDivSpanLabel">
                                <label>Subscriber No:</label>
                            </span>
                            <span class="IASFormDivSpanInputBox">
                                <input autocomplete="off" class="IASTextBox" TABINDEX="1" type="text" name="subscriberId" id="subscriberId" value=""/>
                                <button type="button" id="btnSearchSubscriber" TABINDEX="2">Search Subscriber</button>
                                <button type="button" id="btnCreateSubscriber" TABINDEX="3">Create Subscriber</button>
                            </span>                            
                        </div>
                        <div class="IASFormRightDiv">
                            <span class="IASFormDivSpanLabel">
                                <label>Subscriber Name:</label>
                            </span>
                            <span class="IASFormDivSpanInputBox">
                                <input class="IASTextBoxWide" TABINDEX="1" type="text" name="subscriberName" id="from"/>
                            </span>
                        </div>
                        <div class="IASFormFieldDiv" id="divsubscriberdtls">
                            <%@include file="../subscriber/subscriberdtls.jsp" %>
                            <div class="singleActionBtnDiv">
                                <button class ="IASButton" type="button" id="btnCreateSubscription" TABINDEX="2">Create Subscription</button>
                                <button class ="IASButton" type="button" id="btnCompleteInward" TABINDEX="3" disabled>Save</button>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <div id="divAgentXLUpload">
                    <fieldset class="subMainFieldSet">
                        <%@include file="../inward/agentexcelupload.jsp" %>
                    </fieldset>
                </div>
                <div class="IASFormFieldDiv" id="divManualProc">
                    <table class="datatable" id="resultTable"></table>
                    <div id="pager"></div>
                </div>
            </div>

        </div>
    </body>
</html>