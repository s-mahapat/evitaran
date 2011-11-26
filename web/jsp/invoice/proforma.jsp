<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/invoice/invoice.css"%>" media="screen"/>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/invoice/invoiceprint.css"%>" media="print"/>
        <title>Proforma Invoice</title>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form name="pfinvoice">
                <div class="InvoiceMainDiv">
                    <div class="InvoiceSubMainDiv">
                        <fieldset class="subMainFieldSet">
                            <div class="invoceTelephoneDiv">
                                Phone: 3342546<br>
                                TELEX: <br>
                                TELEFAX: 91-803346094<br>
                            </div>
                            <div id="IASLetterHeadHeader">
                                Indian Academy of sciences</br>
                                c.v. Raman Avenue
                            </div>
                            <div class="invoiceLeftDiv">
                                <span class="IASFormDivSpanLabel">
                                    SUB.NO.
                                </span>
                            </div>
                            <div class="invoiceRightDiv">
                                <span class="IASFormDivSpanLabel">
                                    DATE: 22/11/2011
                                </span>
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
                                        Head</br>
                                        Department of Physics</br>
                                        TM Bhagalpur University</br>
                                        Bhagalpur 812007 Bihar</br>
                                    </span>
                                </div>
                                <div class="invoiceRightDiv">
                                    <span class="invoiceSubscriberAddressSpan">
                                        Head</br>
                                        Department of Physics</br>
                                        TM Bhagalpur University</br>
                                        Bhagalpur 812007 Bihar</br>
                                    </span>
                                </div>
                            </div>
                            <div class="invoiceLeftDiv">
                                <p>
                                    Sub:- Your Subscription to
                                </p>
                            </div>
                            <div class="invoiceWideDiv">
                                <span class="invoiceSubscriptionDetails">
                                    <ul>
                                        <li>
                                            Pramana (1 year)
                                        </li>
                                        <li>
                                            Bulletin of material science(1 year)
                                        </li>
                                    </ul>
                                </span>
                            </div>
                            <div class="invoiceBody">
                                <p>
                                    Dear Sir/Madam,
                                </p>
                                <p>
                                    We have received your order form
                                </p>
                                <p>
                                    As desired, we enclose our Invoice No. 12345 date 22/11/2011 for Rs 1000.
                                    Please arrange an early payment by means of a <label class="underlineText">Bank Draft (or) Cheque drawn in
                                        favour of <b>INDIAN ACADEMY OF SCIENCES, BANGALORE</b></label>
                                </p>
                                <p>
                                    Thanking You,
                                </p>
                            </div>
                            <div class="invoiceRightDiv">
                                <p>
                                    Yours sincerely,
                                </p>
                                <p>&nbsp;</p>
                                <p>
                                    For Circulation Department
                                </p>
                            </div>
                            <div class="invoiceLeftDiv">
                                <p>
                                    Inward No: 12456</br>
                                    Email: office@ias.ernet.in
                                </p>
                            </div>
                            <div class="invoiceWideDiv">
                                <p id="invoiceNoticeParagraph">
                                    Please always quote the above mentioned <b>SUB.NO.</b>
                                    in all correspondence, claims, etc.
                                </p>

                            </div>
                        </fieldset>
                        <!-- Start of next page -->
                        <fieldset class="subMainFieldSet">
                            <div class="pageBreak">
                                <div class="invoiceLeftDiv">
                                    <span class="IASFormDivSpanLabel">
                                        SUB.NO.
                                    </span>
                                </div>
                                <div class="invoiceRightDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <p>PRO.INV.NO: 2241/22</p>
                                        DATE: 22/11/2011
                                    </span>
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
                                            Head</br>
                                            Department of Physics</br>
                                            TM Bhagalpur University</br>
                                            Bhagalpur 812007 Bihar</br>
                                        </span>
                                    </div>
                                    <div class="invoiceRightDiv">
                                        <span class="invoiceSubscriberAddressSpan">
                                            Head</br>
                                            Department of Physics</br>
                                            TM Bhagalpur University</br>
                                            Bhagalpur 812007 Bihar</br>
                                        </span>
                                    </div>
                                </div>
                                <div class="invoiceBody">
                                    <p>
                                        Subscription to the following journal(s) for the year(s) 2011
                                    </p>
                                    <table class="invoiceSubscriptionListTable">
                                        <thead>
                                            <tr>
                                                <td>Journal Name</td>
                                                <td>No. Of Years</td>
                                                <td>Cost(Rs)</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Pramana</td>
                                                <td>1 year</td>
                                                <td>300</td>
                                            </tr>
                                            <tr>
                                                <td>Bulletin of material science</td>
                                                <td>1 Year</td>
                                                <td>700</td>
                                            </tr>
                                            <tr>
                                                <td>Total</td>
                                                <td>&nbsp;</td>
                                                <td>1000</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="invoiceRightDiv">
                                    <p>&nbsp;</p>
                                    <p>&nbsp;</p>
                                    <p>&nbsp;</p>
                                    <p>
                                        For Circulation Department
                                    </p>
                                </div>
                            </div>

                        </fieldset>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>