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
        </head>
        <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <div class="MainDiv">
                <%String inwardNumber = invoiceFormBean.getInwardNumber();%>
                <iframe id="form-iframe" style="width: 100%; height: 80%;" frameborder="1" scrolling="yes" src="print/inward/<%=inwardNumber%>/opb"></iframe>
                <fieldset class="subMainFieldSet">
                    <div class="actionBtnDiv">
                        <%                    String isDisabled = "enabled";
                            if (invoiceFormBean.getEmail() == null || invoiceFormBean.getEmail().length() == 0) {
                                isDisabled = "disabled";
                            }
                        %>
                        <input class="IASButton" id="btnEmail" value="Email" type="button" <%=isDisabled%> onclick="jdsEmail('email/inward/<%=inwardNumber%>/opb')"/>
                    </div>
                </fieldset>
            </div>
        </div>
    </body>
</html>
