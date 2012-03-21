<jsp:useBean class="IAS.Bean.Inward.inwardFormBean" id="inwardFormBean" scope="request"></jsp:useBean>
<div class="MainDiv">
    <fieldset class="subMainFieldSet">
        <div id="letterDiv">
            <%@include file="../templates/letterhead.jsp" %>
            <div class="subjectLine">
                Subscription No:
            </div>
            <div class="subjectLine">
                Subject: Regarding subscription of the Journals
            </div>
            <div class="subjectLine">
                Your letter no.____ Dated: _____
            </div>
            <div class="salutation">
                Dear Sir/Madam,
            </div>
            <div class="letterBody">

                This is to acknowledge with thanks the receipt of the Cheque/DD No: ${inwardFormBean.chqddNumberAsText} of Amount Rs. ${inwardFormBean.amount} towards subscription to the following journals.

                <br>

                Your subscription will be valid for all issues published from the month of ___ to ____

            </div>
        </div>
    </fieldset>
</div>