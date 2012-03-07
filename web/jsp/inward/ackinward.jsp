
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
            <link rel="stylesheet" type="text/css" href="css/inward/ackinward.css"/>
            <title>Acknowledge Inward</title>
        </head>
        <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <div class="MainDiv">
                <fieldset class="subMainFieldSet">
                    <div id="letterDiv">
                        <%@include file="../templates/letterhead.jsp" %>
                        <div class="subjectLine">
                            Subscription No:
                        </div>
                        <div class="subjectLine">
                            Subject: Regarding subscription of the Journals
                        </div>
                        <div class="subjectLine">
                            Your letter no.____ Dated: _____
                        </div>
                        <div class="salutation">
                            Dear Sir/Madam,
                        </div>
                        <div class="letterBody">

                            This is to acknowledge with thanks the receipt of the Cheque/DD no of Amount Rs. towards subscription to the following journals.
                            Your subscription will be valid for all issues published from the month of ___ to ____
                            
                        </div>
                    </div>
                </fieldset>
            </div>


        </div>
    </body>
</html>
