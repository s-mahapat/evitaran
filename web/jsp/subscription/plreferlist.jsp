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
                GeneratePRLGrid();
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
                                <span class="IASFormDivSpanLabel">
                                    <label>Medium</label>
                                </span>
                                <span class="IASFormDivSpanInputBox">
                                    <select class="IASComboBoxMandatory" TABINDEX="1" name="prlmedium" id="prlmedium">
                                        <option value="0">Select</option>
                                        <option value="1">Email Only</option>
                                        <option value="2">Print Only</option>
                                        <option value="3">Print All</option>
                                    </select>
                                </span>
                            </div>
                        </div>
                        <div class="IASFormRightDiv">
                            <button id="btngenerateprl" class="IASButton">Generate</button>
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
