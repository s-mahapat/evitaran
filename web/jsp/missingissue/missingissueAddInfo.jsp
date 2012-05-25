
<%@page import="IAS.Bean.Inward.inwardFormBean"%>
<jsp:useBean class="IAS.Bean.missingissue.missingissueFormBean" id="missingissueFormBean" scope="request"></jsp:useBean>
<%
    inwardFormBean _inwardFormBean = (inwardFormBean)request.getSession().getAttribute("inwardUnderProcess");
    String inwardNumber = _inwardFormBean.getInwardNumber();
    String inwardPurpose = request.getParameter("purpose");

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/missingissue/missingissue.css"%>"/>
        <title>Add New Subscription</title>
        <script type="text/javascript" src="js/common.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/missingissue/missingissue.js"%>"></script>     
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form name="addMissingissueForm" action="missingissue?action=missinglist" method="POST">
                <input type="hidden" name="purpose" id="purpose"/>

                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Add Missing Issue</legend>
                        <fieldset class="subMainFieldSet">
                            <legend>Subscription Details</legend>

                            <div class="IASFormLeftDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward Number:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="inwardNumber" id="inwardNumber" value="<%=inwardNumber%>"/>
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
                        <%@include file="selectmissingjournal.jsp"%>
                        <fieldset class="subMainFieldSet">
                            <div class="actionBtnDiv">
                                <input type="hidden" name="action" id="action"/>
                                <input onclick="saveMissingInfo()" class="IASButton" TABINDEX="101" type="button" value="Save" id="btnsaveMissingInfo" name="btnSubmitAction"/>
                            </div>
                        </fieldset>                        
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>