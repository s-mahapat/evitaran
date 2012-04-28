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
        <script>
            $(document).ready(function(){
                inwardGridCreated = false;
                subscriptionGridCreated = false;
                var tab_cookie_id = parseInt($.cookie("the_tab_cookie")) || 0;
                $("#subscriberDtlsTabs").tabs({
                    selected:-1,
                    show: function(event,ui){

                        selected_index = ui.index;
                        $.cookie("the_tab_cookie", selected_index);

                        if(selected_index == 1 && inwardGridCreated==false){
                            drawInwardTable();
                            inwardGridCreated=true;

                        }
                        if(selected_index == 2 && subscriptionGridCreated==false){
                            listSubscription();
                            subscriptionGridCreated=true;
                            //$("#subscriptionList").jqGrid('setCaption','').trigger("reloadGrid");

                        }

                    }
                });
                $("#subscriberDtlsTabs" ).tabs( "select", tab_cookie_id );

                makeReadOnly();
                makeViewSubscriberReadOnly();
                subtypeCodeAppend();

            });


        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/subscriber"%>" name="subscriberForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>View Subscriber</legend>
                        <fieldset class="subMainFieldSet">

                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Number:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" readonly type="text" name="subscriberNumber" id="subscriberNumber" value="${subscriberFormBean.subscriberNumber}"/>
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

                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Address:</label>
                                    </span>

                                    <span class="IASFormDivSpanInputBox">
                                        <textarea class="IASTextAreaMandatory" TABINDEX="2" name="subscriberAddress" id="subscriberAddress">${subscriberFormBean.subscriberAddress}</textarea>
                                    </span>
                                </div>
                            </div>
                        </fieldset>
                        <fieldset class="subMainFieldSet" style="border: none">
                            <div id="subscriberDtlsTabs" style="font-size: 12px; font-family: cambria,serif" >
                                <ul>
                                    <li><a href="#subDtls">Subscriber Details</a></li>
                                    <li><a href="#inwards">Inwards</a></li>
                                    <li><a href="#subscriptions">Subscriptions</a></li>
                                    <li><a href="#invoices">Invoices</a></li>
                                    <li><a href="#reminders">Reminders</a></li>
                                </ul>
                                <div id="subDtls" style="font-size: 12px; font-family: cambria,serif">
                                    <%@include file="subscriberdtls.jsp"%>
                                </div>

                                <div id="inwards" style="width: 97%;margin-right: 5px;">
                                    <table id="inwardTable" class="datatable"></table>
                                    <div id="pager"></div>

                                </div>

                                <div id="subscriptions">
                                    <table id="subscriptionList" class="datatable"></table>
                                    <div id="pager"></div>
                                </div>

                                <div id="invoices">

                                </div>

                                <div id="reminders">

                                </div>


                            </div>

                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>