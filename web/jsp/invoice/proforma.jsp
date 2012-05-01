<jsp:useBean class="IAS.Bean.Invoice.InvoiceFormBean" id="invoiceFormBean" scope="request"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/invoice/invoice.css"/>
        <link rel="stylesheet" media="print" type="text/css" href="css/print.css"/>
        <title>Proforma Invoice</title>

        <script type="text/javascript">
            $(document).ready(function(){

                $.ajax({
                    type: 'GET',
                    dataType: 'xml',
                    url: "subscription?oper=getSubscriptionDetalsForInward&inwardNumber=" + "${invoiceFormBean.inwardNumber}",
                    success: function(xmlResponse, textStatus, jqXHR){
                        var html = "<tbody>";
                        $(xmlResponse).find("results").find("row").each(function(){

                            html += "<tr>";
                            // get the journal id and set it in the UI
                            subscriptionID = $(this).find("subscriptionid").text();
                            $("#subscriptionID").text(subscriptionID);

                            //get the journal name
                            journalName = $(this).find("journalName").text();

                            //get the start year, end year and copies
                            startYear = $(this).find("startYear").text();
                            endYear = $(this).find("endYear").text();
                            copies = $(this).find("copies").text();

                            html += "<td>" + journalName + "</td>"
                            html += "<td>" + startYear + "</td>"
                            html += "<td>" + endYear + "</td>"
                            html += "<td>" + copies + "</td>"
                            html += "</tr>";

                        });
                        html += "</tbody>";
                        var _orightml = $(".datatable").html();
                        html = _orightml + html;
                        $(".datatable").html(html);
                    },
                    error: function(jqXHR,textStatus,errorThrown){
                        alert("Failed to get subscription information for Inward. Error:" + textStatus + " : "+ errorThrown);
                    }

                });

            });

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
                            <div id="invoceHeaderDiv">
                                <span style= "float:left ; margin-left: 20%"><strong>Subscription No:</strong>${invoiceFormBean.subscriptionID}</span>
                                <span style= "float:right ; margin-right: 20%">Date: <%=util.getDateString()%></span>
                            </div>
                            <div id="invoceHeaderDiv" style="float: left"><hr style=" l"></div>

                            <div class="invoceAddressHeaderDiv">
                                <div class="invoiceLeftDiv">
                                    <span class="invoiceSubscriberAddressHeaderSpan">
                                        INVOICE ADDRESS
                                    </span>
                                </div>
                                <div class="invoiceRightDiv">
                                    <span class="invoiceSubscriberAddressHeaderSpan">
                                        SHIPPING ADDRESS
                                    </span>
                                </div>
                            </div>
                            <div class="invoceAddressDiv">
                                <div class="invoiceLeftDiv">
                                    <span class="invoiceSubscriberAddressSpan">
                                        ${invoiceFormBean.subscriberAddress}
                                    </span>
                                </div>
                                <div class="invoiceRightDiv">
                                    <span class="invoiceSubscriberAddressSpan">
                                        ${invoiceFormBean.subscriberAddress}
                                    </span>
                                </div>
                            </div>

                            <div class="invoiceLetterBody" style="margin-top: 50px;">
                                Dear Sir/Madam,
                            </div>
                            <div class="invoiceLetterBody">
                                We have received your order form
                            </div>
                            <div class="invoiceLetterBody">
                                As desired, we enclose our Invoice No. ${invoiceFormBean.invoiceNumber} date ${invoiceFormBean.invoiceCreationDate}
                                for Rs. ${invoiceFormBean.subscriptionTotal}. Please arrange an early payment <label class="underlineText">by means
                                    of a Bank Draft (or) Cheque drawn in favour of <b>INDIAN ACADEMY OF SCIENCES, BANGALORE</b></label>

                            </div>
                            <div id="subscriptionDetail">
                                <table class="datatable" style="width: 100%">
                                    <tr>
                                        <th>Journal Name</th>
                                        <th>Start Year</th>
                                        <th>End Year</th>
                                        <th>Copies</th>
                                    </tr>
                                </table>
                            </div>

                            <div class="invoiceRightDiv">
                                <p>Thanking You,</p>
                                <p>Yours sincerely,</p>
                                <p>&nbsp;</p>
                                <p>For Circulation Department</p>
                            </div>
                            <div class="invoiceLeftDiv">
                                <p>
                                    Inward No: ${invoiceFormBean.inwardNumber}</br>
                                    Email: office@ias.ernet.in
                                </p>
                            </div>
                            <div class="invoiceWideDiv">
                                <p id="invoiceNoticeParagraph">
                                    Please always quote the above mentioned <b>SUB.NO.</b>
                                    in all correspondence, claims, etc.
                                </p>
                            </div>
                        </div>
                    </fieldset>
                    <fieldset class="subMainFieldSet">
                        <div class="actionBtnDiv">
                            <input class="IASButton" id="btnPrint" value="Print" type="button" onclick="javascript:window.print()"/>
                        </div>
                    </fieldset>
                </fieldset>
            </div>
        </div>
    </body>
</html>
