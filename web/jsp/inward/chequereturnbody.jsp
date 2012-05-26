<%@page import="IAS.Class.util"%>
<%
    IAS.Bean.Inward.inwardFormBean _inwardFormBean = (IAS.Bean.Inward.inwardFormBean)request.getAttribute("inwardFormBean");
%>
<fieldset class="subMainFieldSet" style="border: solid black;border-width: thin;">
    <div id="returnReasonDiv">
        <div style="margin: 0 auto;">
            <%@include file="../templates/letterhead.jsp" %>
        </div>
        
        <div style="float: right; margin-right: 10px">
            Date: <%=util.getDateString()%>
        </div>
        <div class="salutation">
            Dear Sir/Madam,
        </div>
        <div class="subjectLine">
            <strong>Subscriber No: <%=_inwardFormBean.getSubscriberIdAsText()%></strong>                                        
        </div>
        <div class="subjectLine">
            Ref:
        </div>
        <div class="letterBody">
            The Cheque/DD No: <%=_inwardFormBean.getChqddNumberAsText()%> dated <%=_inwardFormBean.getPaymentDate()%> for <%=_inwardFormBean.getCurrency()%> <%=_inwardFormBean.getAmount()%> is returned herewith for want of the following information

            <ul>
                <li id="reasonText">
                    <%
                        String chqReturnReason = _inwardFormBean.getChequeDDReturnReason();
                        if (chqReturnReason != null && !chqReturnReason.isEmpty()) {
                            out.println(chqReturnReason);
                        }
                    %>
                </li>
            </ul>
            <p>
                Inward No: <%=_inwardFormBean.getInwardNumber()%>
            </p>
            <p>&nbsp;</p>
            <p style="margin-left: 70%;">
                Your's Truly<br>
                (Indian Academy of Sciences)
            </p>
        </div>
    </div>

</fieldset>
