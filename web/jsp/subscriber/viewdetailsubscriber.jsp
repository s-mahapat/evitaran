<%--
    Document   : Edit Subscriber
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/subscriber.css"%>"/>
        <title>View Subscriber</title>
        <script type="text/javascript" src="js/common.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscriber/subscriber.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscriber/viewdtlssubscriber.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/inward/subscriberinward.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscription/subscription.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/invoice/subscriberInvoice.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscriber/reminders.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscriber/missingissues.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscriber/chqreturned.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/subscription/paymentinfo.js"%>"></script>
        <script>
            $(document).ready(function(){
                inwardGridCreated = false;
                subscriptionGridCreated = false;
                invoiceGridCreated = false;
                reminderGridCreated = false;
                missingIssueGridCreated = false;
                chqReturnGridCreated = false;
                //paymentGridCreated = false;
                var detail_requested = <%=request.getParameter("detail")%>
                var tab_cookie_id = parseInt($.cookie("the_tab_cookie")) || 0;

                setEnterKeyAction(nextSubscriber);

                $("#subscriberDtlsTabs").tabs({
                    selected:-1,
                    show: function(event, ui){
                        if(detail_requested){
                            selected_index = detail_requested;
                        }else{
                            selected_index = ui.index;
                        }

                        $.cookie("the_tab_cookie", selected_index);

                        if(selected_index == 1 && inwardGridCreated==false){
                            drawInwardTable();
                            inwardGridCreated=true;
                        }
                        else if(selected_index == 2 && subscriptionGridCreated==false){
                            listSubscription();
                            subscriptionGridCreated=true;
                            //$("#subscriptionList").jqGrid('setCaption','').trigger("reloadGrid");
                        }
                        else if(selected_index == 3 && invoiceGridCreated==false){
                            drawInvoiceTable();
                            invoiceGridCreated=true;
                        }
                        /*else if(selected_index == 4 && paymentGridCreated==false){
                            drawPaymentTable();
                            paymentGridCreated=true;
                        }*/
                        else if(selected_index == 4 && reminderGridCreated == false){
                            drawReminderTable();
                            reminderGridCreated = true;
                        }
                        else if(selected_index == 5 && missingIssueGridCreated == false){
                            drawMissingIssuesTable();
                            missingIssueGridCreated = true;
                        }
                        else if(selected_index == 6 && chqReturnGridCreated == false){
                            drawChequeReturnTable();
                            chqReturnGridCreated = true;
                        }

                    }
                });


                if(detail_requested){
                    $("#subscriberDtlsTabs" ).tabs( "select", detail_requested );
                    detail_requested = null;
                }else{
                    $("#subscriberDtlsTabs" ).tabs( "select", tab_cookie_id );
                }

                makeReadOnly();
                makeViewSubscriberReadOnly();
                subtypeCodeAppend();

            });

            function nextSubscriber(){
                $("#btnNextSubscriber").click();
            }
        </script>
        <style>
            .datatable table{
                width: 99%;
            }
            .datatable table tr td{
                font-size: small;
            }
        </style>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/subscriber"%>" name="subscriberForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>View Subscriber</legend>
                        <fieldset class="subMainFieldSet">

                            <div class="IASFormLeftDivSmaller">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Number:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" readonly type="text" name="subscriberNumber" id="subscriberNumber" value="${subscriberFormBean.subscriberNumber}"/>
                                        <input type="hidden" name="subscriberid" id="subscriberid" value="${subscriberFormBean.subscriberID}"/>
                                        <input type="hidden" name="subtypeid" id="subtypeid" value="${subscriberFormBean.subtypeID}"/>
                                    </span>
                                </div>


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Name:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBoxMandatoryWide" TABINDEX="1" type="text" name="subscriberName" id="subscriberName" value="${subscriberFormBean.subscriberName}"/>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormRightDivBigger">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Shipping Address:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <textarea onkeypress="return imposeMaxLength(event, this, 64);" rows="4" cols="35" style="width: 210px;" class="IASTextAreaMandatory" TABINDEX="3" name="shippingAddress" id="shippingAddress">${subscriberFormBean.shippingAddress}</textarea>
                                    </span>

                                    <span class="IASFormDivSpanLabel">
                                        <label>Invoice Address:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <textarea onkeypress="return imposeMaxLength(event, this, 64);" rows="4" cols="35" style="width: 200px;" class="IASTextAreaMandatory" TABINDEX="2" name="invoiceAddress" id="invoiceAddress">${subscriberFormBean.invoiceAddress}</textarea>
                                    </span>
                                </div>
                            </div>
                        </fieldset>
                        <fieldset class="subMainFieldSet" style="border: none">
                            <div id="subscriberDtlsTabs" style="padding-left: 0px;font-size: 12px;" >
                                <ul>
                                    <li><a href="#subDtls">Subscriber Details</a></li>
                                    <li><a href="#inwards">Inwards</a></li>
                                    <li><a href="#subscriptions">Subscriptions</a></li>
                                    <li><a href="#invoices">Invoices</a></li>
                                    <li><a href="#reminders">Reminders</a></li>
                                    <li><a href="#missing_issues">Missing Issues</a></li>
                                    <li><a href="#chq_return">Cheque Return</a></li>
                                </ul>
                                <div id="subDtls" style="font-size: 12px;">
                                    <%@include file="subscriberdtls.jsp"%>
                                </div>

                                <div id="inwards" style="font-size: 12px;width: 98%;padding: 3px;">
                                    <table id="inwardTable" class="datatable" style="padding-bottom: 3px;"></table>
                                    <div id="pager"></div>

                                </div>

                                <div id="subscriptions" style="font-size: 12px;width: 98%;padding: 3px;">
                                    <table id="subscriptionList" class="datatable"></table>
                                    <div id="pager"></div>
                                </div>

                                <div id="invoices" style="font-size: 12px;width: 98%;padding: 3px;">
                                    <table id="invoiceTable" class="datatable"></table>
                                    <div id="pager_invoice"></div>
                                </div>

                                <div id="reminders" style="font-size: 12px;width: 98%;padding: 3px;">
                                    <table id="remindersTable" class="datatable"></table>
                                    <div id="pager_reminders"></div>
                                </div>

                                <div id="missing_issues" style="font-size: 12px;width: 98%;padding: 3px;">
                                    <table id="missing_issuesTable" class="datatable"></table>
                                    <div id="pager_missing_issues"></div>
                                </div>
                                <div id="chq_return" style="font-size: 12px;width: 98%;padding: 3px;">
                                    <table id="chqreturnTable" class="datatable"></table>
                                    <div id="pager_chqreturn"></div>
                                </div>
                                <div id="paymentDetails" title="Payment Details">
                                    <table id="paymentDetailsTable" class="datatable"></table>
                                </div>
                            </div>

                        </fieldset>
                        <fieldset class="subMainFieldSet">
                            <div class="actionBtnDiv">
                                <input onclick="location.href='subscriber?action=nextsubscriber&sid=' + $('#subscriberid').val()" TABINDEX="30" class="IASButton" type="button" value="Next Subscriber" id="btnNextSubscriber" name="btnNextSubscriber"/>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>