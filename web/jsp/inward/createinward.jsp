<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <jsp:include page="../templates/style.jsp"></jsp:include>
            <link rel="stylesheet" type="text/css" href="css/inward/inward.css"/>
            <title>Create Inward</title>
            <script type="text/javascript" src="<%=request.getContextPath()%>/js/inward/createinward.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/city.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/district.js"></script>

        <script>
            var isCitySelected = false;
            var isDistrictSelected = false;

            $(document).ready(function() {
                loadData();
                makeReadOnly();
                //setEnterKeyAction(ValidateSubscriber);

                // disable the form submit on pressing enter
                $("#subscriberId").bind("keypress", function(e) {
                    if (e.keyCode == 13) {
                        ValidateSubscriber();
                        return false;
                    }
                });

                $("#inwardForm").validate({
                    rules: {
                        pincode: {
                            required: false,
                            digits: true
                        },
                        chqddNumber:{
                            required: false,
                            digits: true
                        },
                        city:{
                            required: true
                        }
                    }
                });
                jQueryCalendar("paymentDate", true);
                jQueryCalendar("letterDate", true);
            });
            var myArr = new Array;
        </script>
        <style>
            input.error { border: 1px solid red; }
            label.error {
                margin-left: 5px;
                font-size: 0.8em;
            }
        </style>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/inward"%>" name="inwardForm" id="inwardForm" onsubmit="return validateNewInward()">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Create Inward</legend>
                        <%@include file="inward.jsp"%>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>