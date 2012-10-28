<%@page errorPage="../errors/error.jsp" %>
<jsp:useBean class="IAS.Bean.Inward.inwardFormBean" id="inwardFormBean" scope="request"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/inward/inward.css"/>
        <link rel="stylesheet" media="print" type="text/css" href="css/inward/printchequereturn.css"/>
        <title>Cheque/DD Return</title>
        <script type="text/javascript" src="js/jquery/jquery.print-preview.js"></script>
        <link rel="stylesheet"  media="screen" type="text/css" href="<%=request.getContextPath() + "/css/jquery/print-preview.css"%>"/>
        <script type="text/javascript" src="<%=request.getContextPath() + "/js/inward/returninward.js"%>"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=return_reason"%>","return_reason","chequeDDReturnReason");
                if(document.getElementById("chequeDDReturnReason").value == "NULL"){
                    $("#btnPrintPreview").button("disable");
                    $("#btnEmail").button("disable");
                    //document.getElementById("btnPrintPreview").disabled = true;
                }else{
                    $("#btnPrintPreview").button("enable");
                    $("#btnEmail").button("enable");
                    //document.getElementById("btnPrintPreview").disabled = false;
                }
                
                if(isEmptyValue($("#email").val())){
                    $("#btnEmail").button("disable");
                }
            })

        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form name="chequeReturn" id="chequeReturn" action="<%=request.getContextPath() + "/inward"%>" method="post" onsubmit="return validate()">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <fieldset class="subMainFieldSet" id="chqDDReturnFields">
                            <legend>Cheque/DD Return</legend>
                            <div class="IASFormLeftDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward Number:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="inwardNumber" id="inwardNumber" value="<jsp:getProperty name="inwardFormBean" property="inwardNumber"/>"/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber ID:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="subscriberId" id="subscriberId" value="${inwardFormBean.subscriberIdAsText}"/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>From:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBoxWide" maxlength="64" readonly TABINDEX="-1" type="text" name="from" id="from" value="<jsp:getProperty name="inwardFormBean" property="from"/>"/>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Reason For Return:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <select class="IASComboBoxWideMandatory" TABINDEX="1" name="chequeDDReturnReason" id="chequeDDReturnReason" onchange="enableOtherReason()">
                                            <option value="NULL">Select</option>
                                            <%
                                                if (inwardFormBean.getChequeDDReturnReason() != null && inwardFormBean.getChequeDDReturnReason().isEmpty() == false) {
                                                    out.println("<option value=" + "\"" + inwardFormBean.getChequeDDReturnReason() + "\"" + " selected >" + inwardFormBean.getChequeDDReturnReason() + "</option>");
                                                }
                                            %>

                                        </select>
                                    </span>

                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Other Reason:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBoxWide" TABINDEX="-1" maxlength="64" disabled type="text" name="chequeDDReturnReasonOther" id="chequeDDReturnReasonOther" value="${inwardFormBean.chequeDDReturnReasonOther}" onblur="setOtherReturnReason()"/>
                                    </span>
                                </div>

                            </div>
                            <div class="IASFormRightDiv">

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Inward ID:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="inwardID" id="inwardID" value="${inwardFormBean.inwardID}"/>
                                    </span>
                                </div>
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Cheque/DD No:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBoxMandatory" maxlength="11" TABINDEX="-1" type="text" name="chqddNumber" id="chqddNumber" value="${inwardFormBean.chqddNumberAsText}"/>
                                    </span>
                                </div>


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Payment Date:</label>
                                    </span>
                                    <div class="dateDiv" id="dateDiv"></div>
                                    <span class="IASFormDivSpanInputBox">
                                        <input type="text" class="IASDateTextBox" TABINDEX="-1" readonly size="10" name="paymentDate" id="paymentDate" value="${inwardFormBean.paymentDate}"/>
                                    </span>

                                </div>


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Amount:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBox" TABINDEX="-1" readonly type="text" name="amount" id="amount" value="${inwardFormBean.amount}"/>
                                        <label>${inwardFormBean.currency}</label>
                                    </span>
                                </div>

                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Email:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASDisabledTextBoxWide" TABINDEX="-1" readonly type="text" name="email" id="email" value="${inwardFormBean.email}"/>
                                    </span>
                                </div>


                            </div>
                        </fieldset>
                        <%--<%@include file="chequereturnbody.jsp" %>--%>
                        <fieldset class="subMainFieldSet">
                            <div class="actionBtnDiv" style="margin-top: 20px;">
                                <input onclick="setActionValue('saveReturn')" TABINDEX="2" class="IASButton" type="submit" value="Save" id="btnSaveReturn" name="btnSaveReturn"/>
                                <input TABINDEX="3" class="IASButton" type="button" value="Print" id="btnPrintPreview" name="btnPrintPreview" onclick="showChequeDDReturnPrintPreview('print/inward/${inwardFormBean.inwardNumber}/chqreturn')"/>                               
                                <input TABINDEX="4" class="IASButton" type="button" value="Email" id="btnEmail" name="btnEmail" onclick="jdsEmail('Email/inward/${inwardFormBean.inwardNumber}/chqreturn')"/>
                            </div>
                            <div class="actionBtnDiv" style="margin-top: 15px;color: green">
                                <%
                                    if (inwardFormBean.getChequeDDReturnReason() != null && !inwardFormBean.getChequeDDReturnReason().isEmpty()) {
                                        out.println("The Cheque/DD/MO return reason is saved successfully");
                                    }
                                %>
                            </div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
        <div id="printPreview"></div>
    </body>
</html>
