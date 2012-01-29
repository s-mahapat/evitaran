<%@page errorPage="../errorHandler"%>
<%@page import="IAS.Class.util"%>

<jsp:useBean class="IAS.Bean.masterdata.agentFormBean" id="agentFormBean" scope="request"></jsp:useBean>
<script type="text/javascript">
    $(document).ready(function() {
        jdsAppend("<%=request.getContextPath() + "/CMasterData?md=country"%>","country","country");
        jdsAppend("<%=request.getContextPath() + "/CMasterData?md=state"%>","state","state");
        jdsAppend("<%=request.getContextPath() + "/CMasterData?md=district"%>","district","district");
        jdsAppend("<%=request.getContextPath() + "/CMasterData?md=city"%>","city","city");
    });

    jQueryCalendar("regDate");
</script>
<%-----------------------------------------------------------------------------------------------------%>
<%-- Agent Data Basic data Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>

<fieldset class="subMainFieldSet">
    <legend>Agent Details</legend>
    <div class="IASFormFieldDiv">
        <div class="IASFormLeftDiv">
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Agent Id:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="1" type="text" name="agentId" id="agentId" value="<jsp:getProperty name="agentFormBean" property="agentId"/>"/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Agent Name:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBoxMandatory" TABINDEX="10" type="text" name="agentName" id="agentName" value="<jsp:getProperty name="agentFormBean" property="agentName"/>"/>
                </span>
            </div>
        </div>
        <div class="IASFormRightDiv">

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Registration Date:</label>
                </span>
                <%------ From Date Input Box ------%>
                <span class="IASFormDivSpanInputBox">
                     <input type="text" class="IASDateTextBox" readonly size="10" name="regDate" id="${agentFormBean.regDate}"/>
                </span>
           </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Discount%:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="discount" id="discount" value="<jsp:getProperty name="agentFormBean" property="discount"/>"/>
                </span>
            </div>                    
         </div>
    </div>
</fieldset>
<%-----------------------------------------------------------------------------------------------------%>
<%-- Agent Data Address Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>

<fieldset class="subMainFieldSet">
    <div class="IASFormFieldDiv">
        <legend>Address Details</legend>

        <div class="IASFormLeftDiv">
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>email Id:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="1" type="text" name="emailId" id="emailId" value="${agentFormBean.emailId}"/>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Address:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="address" id="address" value="${agentFormBean.address}"/>
                </span>
            </div>


           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>city:</label>
                </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBoxMandatory" TABINDEX="4" name="city" id="city">
                    <option value="0" selected >Select</option>
                    <%
                        if (!agentFormBean.getCity().isEmpty()) {
                            out.println("<option value=" + "\"" + agentFormBean.getCity() + "\"" + " selected >" + agentFormBean.getCity() + "</option>");
                        }
                    %>
                </select>                
            </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>District:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <select class="IASComboBox" TABINDEX="3" name="district" id="district">
                        <option value="0" selected >Select</option>
                        <%
                            if (!agentFormBean.getDistrict().isEmpty()) {
                                out.println("<option value=" + "\"" + agentFormBean.getDistrict() + "\"" + " selected >" + agentFormBean.getDistrict() + "</option>");
                            }
                        %>
                    </select>
                </span>
            </div>                
         </div>

         <div class="IASFormRightDiv">
           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>State:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <select class="IASComboBox" TABINDEX="3" name="state" id="state">
                        <option value="0" selected >Select</option>
                        <%
                            if (!agentFormBean.getState().isEmpty()) {
                                out.println("<option value=" + "\"" + agentFormBean.getState() + "\"" + " selected >" + agentFormBean.getState() + "</option>");
                            }
                        %>
                    </select>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Country:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="2" name="country" id="country">
                    <option value="0" selected >Select</option>
                    <%
                        if (!agentFormBean.getCountry().isEmpty()) {
                            out.println("<option value=" + "\"" + agentFormBean.getCountry() + "\"" + " selected >" + agentFormBean.getCountry() + "</option>");
                        }
                    %>
                </select>
                </span>
            </div>

           <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>PIN Code:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="10" type="text" name="pinCode" id="pinCode" value="${agentFormBean.pinCode}"/>
                </span>
            </div>
         </div>
    </div>
</fieldset>
<%-----------------------------------------------------------------------------------------------------%>
<%-- Agent Actions Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>

<fieldset class="subMainFieldSet">
    <div class="IASFormFieldDiv">
        <input type="hidden" name="action" id="action"/>
        <div id="saveBtnDiv">
            <input onclick="setActionValue('save')"  class="IASButton" TABINDEX="101" type="submit" value="save" id="btnSave" name="btnSubmitAction"/>
        </div>
        <div id="editBtnDiv">
            <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="101" type="submit" value="edit" id="btnEdit" name="btnSubmitAction"/>
        </div>
    </div>
</fieldset>


