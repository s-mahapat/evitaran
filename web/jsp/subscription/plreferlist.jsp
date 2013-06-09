<%@page import="IAS.Class.util"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <title>Please Refer List</title>
        <script src="js/subscription/prl.js"></script>
        <script>
            $(document).ready(function(){
                $("#btnprintemail").button("disable");
                GeneratePRLGrid(Constants.jqgrid.HEIGHT);
            });
        </script>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <div class="MainDiv">
                <fieldset class="MainFieldset">
                    <legend>Please Refer List</legend>
                    <fieldset class="subMainFieldSet">
                        <div class="IASFormLeftDiv">
                            <div class="IASFormFieldDiv">
                                <label class="inlinelabel">Medium:</label>
                                <span class="inlineinput">
                                    <select class="IASComboBoxMandatory" TABINDEX="1" name="prlmedium" id="prlmedium">
                                        <option value="0">Select</option>
                                        <option value="1">Email Only</option>
                                        <option value="2">Print Only</option>
                                        <option value="3">Print All</option>
                                    </select>
                                </span>
                                <label class="inlinelabel">Subscription expiring in :</label>
                                <span class="inlineinput">
                                    <select class="IASComboBoxMandatory" TABINDEX="2" name="year" id="year">
                                        <%
                                            int year = Integer.parseInt(util.getDateString("yyyy"));
                                            for (int i = year - 1; i <= year + 1; i++) {
                                                String isSelected = "";
                                                if(i == year){
                                                    isSelected = "selected";
                                                }
                                                out.println("<option value=\"" + i + "\" " + isSelected + ">" + i + "</option>");
                                            }
                                        %>
                                    </select>
                                </span>

                            </div>

                        </div>
                        <div class="IASFormRightDiv">
                            <div class="IASFormFieldDiv">
                                <span class="IASFormDivSpanLabel">
                                    <label>Letter Text</label>
                                </span>
                                <span class="IASFormDivSpanInputBox">
                                    <textarea class="IASTextArea" id="ctext" value="" name="ctext" maxlength="200"></textarea>
                                </span>
                            </div>

                        </div>
                        <div class="actionBtnDiv">
                            <button id="btngenerateprl" class="IASButton" onclick="GeneratePRL()">Generate</button>
                            <button id="btnprintemail" class="IASButton" onclick="PrintOrEmail()">Email / Print</button>
                        </div>
                    </fieldset>
                    <fieldset class="subMainFieldSet">
                        <table class="datatable" id="prlTable"></table>
                        <div id="pager"></div>
                    </fieldset>
                </fieldset>
            </div>
        </div>
    </body>
</html>
