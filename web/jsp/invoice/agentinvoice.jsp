<%@page import="IAS.Class.util"%>
<%@page import="IAS.Class.EnglishNumberToWords"%>
<%@page import="IAS.Class.JDSConstants"%>
<jsp:useBean class="IAS.Bean.Invoice.InvoiceFormBean" id="invoiceFormBean" scope="request"></jsp:useBean>
<jsp:useBean class="IAS.Bean.Inward.inwardFormBean" id="inwardFormBean" scope="request"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/invoice/invoice.css"/>
        <link rel="stylesheet" media="print" type="text/css" href="css/print.css"/>
        <title>Invoice</title>
        <script type="text/javascript" src="js/toword.js"></script>
        <script type="text/javascript">
            var _total = 0;
            $(document).ready(function(){
                var html = "<tbody>";
                html += "<tr>";
                var _rowspan = 1;
                html += "<td rowspan=\"" + _rowspan + "\">" + ${invoiceFormBean.subscriptionTotal} + "</td>";
                html += "<td rowspan=\"" + _rowspan + "\">" + ${inwardFormBean.amount} + "</td>";
                html += "<td rowspan=\"" + _rowspan + "\">" + ${invoiceFormBean.balance} + "</td>";
                html += "</tr>";
                html += "</tbody>";
                var _orightml = $(".datatable").html();
                html = _orightml + html;
                $(".datatable").html(html);
                _total = ${invoiceFormBean.amount};
                $("#total").html("INDIAN RS: " + toWords(_total).toUpperCase());
                        
                //disable email button if no email id present
                //var email = "<%--${inwardFormBean.email}--%>";
                //if(isEmptyValue(email)){
                    //$("#btnEmail").button("enable");
                //}
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
                                        Inward. No: ${invoiceFormBean.inwardNumber}
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
                                <%--<div class="invoiceRightDiv">
                                    <span class="invoiceSubscriberAddressHeaderSpan">
                                        SHIPPING ADDRESS
                                    </span>
                                </div>--%>
                            </div>
                            <div class="invoceAddressDiv">
                                <div class="invoiceLeftDiv">
                                    <span class="invoiceSubscriberAddressSpan">
                                        ${inwardFormBean.agentName}</br>
                                        <%
                                            String address = invoiceFormBean.getInvoiceAddress();
                                            if (address != null && address.length() != 0) {
                                                out.println(address + "</br>");
                                            }
                                        %>
                                        <%
                                            String department = invoiceFormBean.getDepartment();
                                            if (department != null && department.length() != 0) {
                                                out.println(department + "</br>");
                                            }
                                        %>
                                        <%
                                            String institute = invoiceFormBean.getInstitute();
                                            if (institute != null && institute.length() != 0) {
                                                out.println(institute + "</br>");
                                            }
                                        %>
                                        <%--${invoiceFormBean.shippingAddress}</br>--%>
                                        ${invoiceFormBean.city}</br>
                                        <%
                                            String country = invoiceFormBean.getCountry();
                                            if (country != null && country.length() != 0 && !country.equals("0")) {
                                                out.println(country + "</br>");
                                            }
                                        %>
                                        <%
                                            String pincode = String.valueOf(invoiceFormBean.getPincode());
                                            if (pincode != null && pincode.length() != 0 && !pincode.equals("0")) {
                                                out.println(pincode + "</br>");
                                            }
                                        %>
                                    </span>
                                </div>
                                       
                            </div>
                            <div id="subscriptionDetail">
                                <table class="datatable" id="invoiceTable" style="width: 100%">
                                    <tr>
                                        <th>Subscription Value</th>
                                        <th>Amount Paid</th>
                                        <th>Balance</th>
                                    </tr>
                                </table>
                            </div>
                            <div class="invoiceLeftDiv" id="total"></div>
                            <div class="invoiceRightDiv">
                                <p><%=JDSConstants.IAS_LETTERFOOT_CLOSING%></p>
                                <p><%=JDSConstants.IAS_LETTERFOOT_SIGNATURE%></p>
                            </div>
                        </div>
                    </fieldset>
                    <fieldset class="subMainFieldSet">
                        <div class="actionBtnDiv">
                            <input class="IASButton" id="btnPrint" value="Print" type="button" onclick="jdsPrint('print/inward/' + $('#inwardNumber').val() + '/agentInvoice', 'Request For Invoice')"/>
                            <%
                                String isDisabled = "enabled";
                                if (invoiceFormBean.getEmail() == null || invoiceFormBean.getEmail().length() == 0) {
                                    isDisabled = "disabled";
                                }
                            %>
                            <input class="IASButton" id="btnEmail" value="Email" type="button" <%=isDisabled%> onclick="jdsEmail('email/inward/' + $('#inwardNumber').val() + '/agentInvoice')"/>
                        </div>
                    </fieldset>
                </fieldset>
            </div>
        </div>
    </body>
</html>
