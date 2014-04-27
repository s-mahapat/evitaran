<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
            <title>Confirm</title>
            <script type="text/javascript">
                var balance = 0;
                $(document).ready(function() {
                    window.returnValue = 0;
                    var subscriber_number = window.dialogArguments;
                    $.ajax({
                        type: "GET",
                        url: "<%=request.getContextPath()%>" + "/subscriber?action=balance&subscriber=" + subscriber_number,
                        async: false,
                        // change to full path of file on server
                        dataType: "json",
                        success: function(json) {
                            balance = parseFloat(json['balance']);
                            if (balance > 0) {
                                //$("#subscriberid").text(subscriber_number);
                                $("#balance").text(balance);
                            }
                            else {
                                $("#balance-message").hide();
                            }
                        }
                    });
                    $("#savebtn").click(function() {
                        window.returnValue = 1;
                        window.close();
                    });
                    $("#paymentbtn").click(function() {
                        window.returnValue = 2;
                        window.close();
                    });
                    $("#cancelbtn").click(function() {
                        window.close();
                    });
                });

        </script>
    </head>
    <body>
        <div id="PopUpbodyContainer">
            <fieldset class="subMainFieldSet">
                <div id="duplicatedialog" style="margin: 20px;">
                    <p>There are subscriptions already existing for the Journals marked in red. <br>Click on Save to continue</p>
                    <p id="balance-message">The subscriber has an outstanding balance of INR <strong><span id="balance"></span></strong></p>
                </div>
                <div class="actionBtnDiv">
                    <button type="button" class="IASButton CancelButton" id="cancelbtn">Cancel</button>
                    <button type="button" class="IASButton SaveButton" id="savebtn">Save</button>
                    <button class="IASButton" id="paymentbtn">Make Payment</button>
                </div>
            </fieldset>
        </div>
    </body>
</html>
