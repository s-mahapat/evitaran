<%@page import="IAS.Class.util"%>
<%@page import="IAS.Class.EnglishNumberToWords"%>
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
        <title>Invoice</title>
        <script type="text/javascript" src="js/toword.js"></script>
        <script type="text/javascript">
            var _total = 0;
            var JournalNamesHash = new Object();
            var JournalYearsHash = new Object();
            var JournalPriceHash = new Object();
            var JournalCopiesHash = new Object();
            $(document).ready(function(){

                $.ajax({
                    type: 'GET',
                    dataType: 'xml',
                    url: "subscription?oper=getSubscriptionDetailsForInward&inwardNumber=" + "${invoiceFormBean.inwardNumber}",
                    success: function(xmlResponse, textStatus, jqXHR){
                        var html = "<tbody>";
                        $(xmlResponse).find("results").find("row").each(function(){

                            // get the journal id and set it in the UI
                            subscriptionID = $(this).find("subscriptionid").text();
                            $("#subscriptionID").text(subscriptionID);

                            //get the journal name
                            journalName = $(this).find("journalName").text();
                            journalGrpID = $(this).find("journalGroupID").text();

                            //maintain copies group wise
                            JournalCopiesHash[journalGrpID] = $(this).find("copies").text();

                            // for each journal group id create an array, this way we
                            // group them on the UI
                            if(JournalNamesHash[journalGrpID] == undefined){
                                JournalNamesHash[journalGrpID] = new Array();
                            }
                            JournalNamesHash[journalGrpID].push(journalName);
                            period = $(this).find("period").text();
                            // similarly we also maintain an array of subscription periods for
                            // each group
                            JournalYearsHash[journalGrpID] = period;
                            grptotal = parseInt($(this).find("total").text());
                            // also maintain totals group wise
                            JournalPriceHash[journalGrpID] = grptotal;

                        });
                        html += "<tr>";
                        var _rowspan = 1;
                        for(var id in JournalNamesHash){
                            _total += JournalPriceHash[id];
                            _rowspan = JournalNamesHash[id].length;
                            var _journals = JournalNamesHash[id];
                            var bprinted = false;
                            for(var indx in _journals){
                                html += "<td class=\"journalname\">" + _journals[indx] + "</td>";
                                if(!bprinted){
                                    html += "<td rowspan=\"" + _rowspan + "\">" + JournalCopiesHash[id] + "</td>";
                                    html += "<td rowspan=\"" + _rowspan + "\">" + JournalYearsHash[id] + "</td>";
                                    html += "<td rowspan=\"" + _rowspan + "\">" + JournalPriceHash[id] + "</td>";
                                    bprinted = true;
                                }
                                html += "</tr>";
                            }


                        }
                        html += "<tr><td>&nbsp;</td><td>&nbsp;</td><td>Total</td><td>" + _total + "</td></tr>"
                        html += "</tbody>";
                        var _orightml = $(".datatable").html();
                        html = _orightml + html;
                        $(".datatable").html(html);
                        $("#total").html("INDIAN RS: " + toWords(_total).toUpperCase());
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
                                            if (_country != null && _country.length() != 0 && !_country.equals("0")) {
                                                out.println(_country + "</br>");
                                            }
                                        %>
                                        <%
                                            String _pincode = String.valueOf(invoiceFormBean.getPincode());
                                            if (_pincode != null && _pincode.length() != 0 && !_pincode.equals("0")) {
                                                out.println(_pincode + "</br>");
                                            }
                                        %>
                                    </span>
                                </div>
                            </div>
                            <div id="subscriptionDetail">
                                <table class="datatable" id="invoiceTable" style="width: 100%">
                                    <tr>
                                        <th>Journal Name</th>
                                        <th>Copies</th>
                                        <th>No. of Years</th>
                                        <th>Rs.</th>
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
                            <input class="IASButton" id="btnPrint" value="Print" type="button" onclick="jdsPrint('print/inward/' + $('#inwardNumber').val() + '/rfi', 'Request For Invoice')"/>
                            <%
                                String isDisabled = "enabled";
                                if (invoiceFormBean.getEmail() == null || invoiceFormBean.getEmail().length() == 0) {
                                    isDisabled = "disabled";
                                }
                            %>
                            <input class="IASButton" id="btnEmail" value="Email" type="button" <%=isDisabled%> onclick="jdsEmail('email/inward/' + $('#inwardNumber').val() + '/rfi')"/>
                        </div>
                    </fieldset>
                </fieldset>
            </div>
        </div>
    </body>
</html>
