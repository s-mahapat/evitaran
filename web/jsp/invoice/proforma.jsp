<%@page import="IAS.Class.util"%>
<%@page import="IAS.Class.JDSConstants"%>
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
            var _total = 0;
            $(document).ready(function(){

                $.ajax({
                    type: 'GET',
                    dataType: 'xml',
                    url: "subscription?oper=getSubscriptionDetailsForInward&inwardNumber=" + "${invoiceFormBean.inwardNumber}",
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
                            //startYear = $(this).find("startYear").text();
                            //endYear = $(this).find("endYear").text();
                            //copies = $(this).find("copies").text();
                            period = $(this).find("period").text();
                            rate = $(this).find("rate").text();
                            _total = _total + parseInt(rate);

                            html += "<td>" + journalName + "</td>"
                            html += "<td>" + period + "</td>"
                            html += "<td>" + rate + "</td>"
                            //html += "<td>" + startYear + "</td>"
                            //html += "<td>" + endYear + "</td>"
                            //html += "<td>" + copies + "</td>"
                            html += "</tr>";

                        });
                        html += "<tr><td>&nbsp;</td><td>Total</td><td>" + _total + "</td></tr>"
                        html += "</tbody>";
                        var _orightml = $(".datatable").html();
                        html = _orightml + html;
                        $(".datatable").html(html);
                    },
                    error: function(jqXHR,textStatus,errorThrown){
                        alert("Failed to get subscription information for Inward. Error:" + textStatus + " : "+ errorThrown);
                    }

                });
                
                //disable email button if no email id present
                var email = "${invoiceFormBean.subscriptionID}";
                if(isEmptyValue(email)){
                    $("#btnEmail").button("disable");
                }

            });

        </script>

    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <div class="MainDiv">
                <input type="hidden" id="inwardNumber" name="inwardNumber" value="${invoiceFormBean.inwardNumber}"/>
                <fieldset class="MainFieldset">
                    <fieldset class="subMainFieldSet">
                        <div id="letterDiv">
                            <%@include file="../templates/letterhead.jsp" %>
                            <div id="invoceHeaderDiv">
                                <span style= "float:right ; margin-right: 20%">Date: <%=util.getDateString()%></span>
                            </div>
                            <div id="invoceHeaderDiv" style="float: left"><hr style=" l"></div>
                            <div class="invoceAddressHeaderDiv">
                                <div class="invoiceLeftDiv">
                                    <span class="invoceAddressHeaderDiv">
                                        Sub. No: ${invoiceFormBean.subscriberNumber}
                                    </span>
                                </div>
                                <div style="margin: 0 auto">INVOICE</div>
                                <div class="invoiceRightDiv">
                                    <span class="invoceAddressHeaderDiv">
                                        Invoice No: ${invoiceFormBean.invoiceNumber}
                                    </span>
                                </div>
                            </div>
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
                                        ${invoiceFormBean.subscriberName}</br>
                                        ${invoiceFormBean.invoiceAddress}
                                    </span>
                                </div>
                                <div class="invoiceRightDiv">
                                    <span class="invoiceSubscriberAddressSpan">
                                        ${invoiceFormBean.subscriberName}</br>
                                        <%
                                            String _department = invoiceFormBean.getDepartment();
                                            if (_department != null && _department.length() != 0) {
                                                out.println(_department + "</br>");
                                            }
                                        %>
                                        <%
                                            String _institute = invoiceFormBean.getInstitute();
                                            if (_institute != null && _institute.length() != 0) {
                                                out.println(_institute + "</br>");
                                            }
                                        %>
                                        ${invoiceFormBean.shippingAddress}</br>
                                        ${invoiceFormBean.city}</br>
                                        <%
                                            String _country = invoiceFormBean.getCountry();
                                            if (_country != null && _country.length() != 0) {
                                                out.println(_country + "</br>");
                                            }
                                        %>
                                        <%
                                            String _pincode = String.valueOf(invoiceFormBean.getPincode());
                                            if (_pincode != null && _pincode.length() != 0) {
                                                out.println(_pincode + "</br>");
                                            }
                                        %>
                                    </span>
                                </div>
                            </div>
                            <div id="subscriptionDetail">
                                <table class="datatable" style="width: 100%">
                                    <tr>
                                        <th>Journal Name</th>
                                        <th>No. of Years</th>
                                        <th>Rs.</th>
                                    </tr>
                                </table>
                            </div>

                            <div class="invoiceRightDiv">
                                <p><%=JDSConstants.IAS_LETTERFOOT_CLOSING%></p>
                                <p><%=JDSConstants.IAS_LETTERFOOT_SIGNATURE%></p>
                            </div>
                        </div>
                    </fieldset>
                    <fieldset class="subMainFieldSet">
                        <div class="actionBtnDiv">
                            <input class="IASButton" id="btnPrint" value="Print" type="button" onclick="jdsPrint('print/inward/' + $('#inwardNumber').val() + '/rfi', 'Request For Invoice')"/>
                            <input class="IASButton" id="btnEmail" value="Email" type="button" onclick="jdsEmail('email/inward/' + $('#inwardNumber').val() + '/rfi')"/>
                        </div>
                    </fieldset>
                </fieldset>
            </div>
        </div>
    </body>
</html>
