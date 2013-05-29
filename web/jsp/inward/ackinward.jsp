<%@page import="IAS.Bean.Inward.inwardFormBean"%>
<%@page import="IAS.Class.InwardAck"%>
<%@page import="IAS.Class.util"%>
<jsp:useBean class="IAS.Bean.Inward.inwardFormBean" id="inwardFormBean" scope="request"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/inward/ackinward.css"/>
        <title>Acknowledge Inward</title>
        <script type="text/javascript">
            var subscriptionID = 0;
            jQueryCalendar("subscriberletterDate", true);
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <div class="MainDiv">
                <fieldset class="MainFieldset">
                    <fieldset class="subMainFieldSet">
                        <div id="letterDiv">
                            <%@include file="../templates/letterhead.jsp" %>
                            <div style="float: right; margin-right: 10px">
                                Date: <%=util.getDateString()%>
                            </div>
                            <div class="subjectLine">
                                <!--<strong>Subscription No:</strong>-->
                                <span style="padding-left: 5px;" id="subscriptionID"></span>
                            </div>
                            <div class="subjectLine">
                                <strong>Subject:</strong> Regarding subscription of the Journals
                            </div>
                            <div class="subjectLine">
                                Your letter no:
                                <span>
                                    <input class="IASTextBox" name="lno" id="letterNumber" type="text" value="${inwardFormBean.letterNumber}">
                                </span>
                                <span>Dated:</span>
                                <span id="letterDateSpan">
                                    <input type="text" class="IASDateTextBox" TABINDEX="2" size="10" id="subscriberletterDate" value="${inwardFormBean.letterDate}"/>
                                </span>
                            </div>
                            <div class="salutation">
                                Dear Sir/Madam,
                            </div>
                            <div class="letterBody">
                                <%
                                    inwardFormBean _inwardFormBean = (inwardFormBean)request.getAttribute("inwardFormBean");
                                    InwardAck _ack = new InwardAck();
                                    String _text = _ack.getText(
                                            _inwardFormBean.getChqddNumberAsText(),
                                            _inwardFormBean.getPaymentDate(),
                                            _inwardFormBean.getAmount(),
                                            _inwardFormBean.getPaymentModeID(),
                                            _inwardFormBean.getInwardPurposeID(),
                                            _inwardFormBean.getLetterNumber(),
                                            _inwardFormBean.getLetterDate());
                                    out.println(_text);
                                %>
                            </div>
                            <div id="customTextDiv" style="margin-left: 5%;float:left;width: 90%;">
                                <textarea style="margin: 10px; width: 85%;" class="IASTextAreaWide" id="customText" maxlength="300" cols="100"></textarea>
                            </div>
                        </div>
                    </fieldset>
                    <fieldset class="subMainFieldSet">
                        <div class="actionBtnDiv">
                            <input class="IASButton" id="btnPrint" value="Print" type="button" onclick="jdsPrint('print/inward/'
                                    + subscriptionID + '/ack?lno='
                                    + $('#letterNumber').val()
                                    + '&ldate=' + $('#subscriberletterDate').val()
                                    + '&inwardNumber=${inwardFormBean.inwardNumber}'
                                    + '&ctext=' + $('#customText').val(), 'Inward Acknowledgement')"/>
                            <%
                                String email = inwardFormBean.getEmail();
                                String bEmail = "enabled";
                                if (email == null || email.isEmpty()) {
                                    bEmail = "disabled";
                                }
                            %>
                            <input class="IASButton" <%=bEmail%> id="btnEmail" value="Email" type="button" onclick="jdsEmail('email/inward/'
                                    + subscriptionID + '/ack?lno='
                                    + $('#letterNumber').val()
                                    + '&ldate=' + $('#subscriberletterDate').val()
                                    + '&inwardNumber=${inwardFormBean.inwardNumber}'
                                    + '&ctext=' + $('#customText').val())"/>
                            <input onclick="location.href='main?action=createinward'" TABINDEX="6" class="IASButton" type="button" value="New Inward" id="btnNewInward" name="btnNewInward"/>
                        </div>
                    </fieldset>
                </fieldset>
            </div>
        </div>
    </body>
</html>
