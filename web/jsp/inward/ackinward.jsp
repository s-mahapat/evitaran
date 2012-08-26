<%@page import="IAS.Class.util"%>
<jsp:useBean class="IAS.Bean.Inward.inwardFormBean" id="inwardFormBean" scope="request"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
            <link rel="stylesheet" type="text/css" href="css/inward/ackinward.css"/>
            <link rel="stylesheet" media="print" type="text/css" href="css/inward/ackinwardprint.css"/>
            <link rel="stylesheet" media="print" type="text/css" href="css/print.css"/>
            <title>Acknowledge Inward</title>
            <script type="text/javascript">
                var subscriptionID = 0;
//                $(document).ready(function(){
//                    jQueryCalendar("subscriberletterDate");
//                    $.ajax({
//                        type: 'GET',
//                        dataType: 'xml',
//                        url: "subscription?oper=getSubscriptionDetailsForInward&inwardNumber=" + "${inwardFormBean.inwardNumber}",
//                        success: function(xmlResponse, textStatus, jqXHR){
//                            var html = "<tbody>";
//                            $(xmlResponse).find("results").find("row").each(function(){
//
//                                html += "<tr>";
//                                // get the journal id and set it in the UI
//                                subscriptionID = $(this).find("subscriptionid").text();
//                                $("#subscriptionID").text(subscriptionID);
//
//                                //get the journal name
//                                journalName = $(this).find("journalName").text();
//
//                                //get the start year, end year and copies
//                                startYear = $(this).find("startYear").text();
//                                endYear = $(this).find("endYear").text();
//                                copies = $(this).find("copies").text();
//
//                                html += "<td>" + journalName + "</td>"
//                                html += "<td>" + startYear + "</td>"
//                                html += "<td>" + endYear + "</td>"
//                                html += "<td>" + copies + "</td>"
//                                html += "</tr>";
//
//                            });
//                            html += "</tbody>";
//                            var _orightml = $(".datatable").html();
//                            html = _orightml + html;
//                            $(".datatable").html(html);
//                        },
//                        error: function(jqXHR,textStatus,errorThrown){
//                            alert("Failed to get subscription information for Inward. Error:" + textStatus + " : "+ errorThrown);
//                        }
//
//                    });
//
//                });

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
                                    <input class="IASTextBox" name="lno" id="letterNumber" type="text" value="">
                                </span>
                                <span>Dated:</span>
                                <span id="letterDateSpan">
                                    <input type="text" class="IASDateTextBox" TABINDEX="2" size="10" id="subscriberletterDate"/>
                                </span>
                            </div>
                            <div class="salutation">
                                Dear Sir/Madam,
                            </div>
                            <div class="letterBody">
                                This is to acknowledge with thanks the receipt of <strong> ${inwardFormBean.paymentMode} ${inwardFormBean.chqddNumberAsText}</strong> of Amount <strong>Rs. ${inwardFormBean.amount}</strong> towards 
                                subscription of Journals
                                <!--towards subscription of the following journals.-->
                            </div>
                            <!--<div id="subscriptionDetail">
                                <table class="datatable" style="width: 100%">
                                    <tr>
                                        <th>Journal Name</th>
                                        <th>Start Year</th>
                                        <th>End Year</th>
                                        <th>Copies</th>
                                    </tr>
                                </table>
                            </div>-->
                            <div id="customTextDiv" style="margin-left: 5%;float:left;width: 90%;">
                                <label>Custom Text: </label>
                                <textarea style="margin-left: 10px; width: 80%;" class="IASTextArea" id="customText" maxlength="300" cols="80"></textarea>
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
                        </div>
                    </fieldset>
                </fieldset>
            </div>
        </div>
    </body>
</html>
