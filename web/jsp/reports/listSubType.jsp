<%--
    Document   : Print Subscriber Type
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp" %>
        <link rel="stylesheet" type="text/css" href="css/report/subType.css" />

        <title>List subscriber type</title>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <form method="post" action="" name="searchSubTypeForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>List and Print Subscriber Type</legend>

                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Criteria Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Criteria</legend>

                            <%-- Search Criteria left div --%>
                            <div class="IASFormLeftDiv">


                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Sub type Code:</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="1" type="text" name="subTypeCode" id="subTypeCode" value=""/>
                                    </span>
                                </div>
                            </div>
                            <div class="IASFormRightDiv">
                                <div class="IASFormFieldDiv">
                                    <span class="IASFormDivSpanLabel">
                                        <label>Subscriber Type</label>
                                    </span>
                                    <span class="IASFormDivSpanInputBox">
                                        <input class="IASTextBox" TABINDEX="2" type="text" name="subType" id="subType" value=""/>
                                    </span>
                                </div>
                            </div>

                            <div class="IASFormFieldDiv">
                                <div id="searchBtnDiv">
                                    <input class="IASButton" TABINDEX="3" type="submit" value="Search"/>
                                </div>

                                <div id="resetBtnDiv">
                                    <input class="IASButton" TABINDEX="4" type="reset" value="Reset"/>
                                </div>
                            </div>

                        </fieldset>



                        <%-----------------------------------------------------------------------------------------------------%>
                        <%-- Search Result Field Set --%>
                        <%-----------------------------------------------------------------------------------------------------%>
                        <fieldset class="subMainFieldSet">
                            <legend>Search Result</legend>

                            <table class="datatable">
                                <thead>
                                    <tr>
                                        <td>Code</td>
                                        <td>Subscriber Type</td>
                                        <td>Free/paid</td>
                                        <td>Number of Free Copies</td>
                                        <td>Discount</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>FELJM</td>
                                        <td>Fellow</td>
                                        <td>Free</td>
                                        <td>2</td>
                                        <td>-</td>                                        
                                    </tr>
                                    <tr>
                                        <td>AUTH</td>
                                        <td>Author</td>
                                        <td>Free</td>
                                        <td>1</td>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <td>AGE</td>
                                        <td>Agent</td>
                                        <td>Paid</td>
                                        <td>0</td>
                                        <td>10%</td>
                                    </tr>
                                    <tr>
                                        <td>KVPY</td>
                                        <td>Kishore Vaigyanik Pariyojana</td>
                                        <td>Paid</td>
                                        <td>1</td>
                                        <td>0</td>
                                    </tr>  
                                </tbody>
                            </table>
                        </fieldset>
                                    
                         <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" type="button" value="Print" onclick="javascript:window.print();"/>
                                </div>
                            </div>
                        </fieldset>
                  
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>