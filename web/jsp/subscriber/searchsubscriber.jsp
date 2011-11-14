<%--
    Document   : searchsubscriber
    Created on : Oct 29, 2011, 8:40:02 PM
    Author     : I036897
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/styleforpopup.jsp"></jsp:include>
        <title>Search Subscriber</title>
    </head>
    <body>

        <div id="bodyContainer">
            <div class="MainDiv">
                <fieldset class="MainFieldset">
                    <legend>Search Subscriber Result</legend>

                    <fieldset class="subMainFieldSet">
                        <legend>Subscriber List</legend>

                        <table class="datatable">
                            <thead>
                                <tr>
                                    <td>Select</td>
                                    <td>Subscriber Id</td>
                                    <td>Subscriber Name</td>
                                    <td>Department</td>
                                    <td>City</td>
                                    <td>Pin Code</td>
                                    <td>Country</td>
                                    <td>Email</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td> <input class="IASRadioButton" TABINDEX="9" type="radio" name="selectSubcriber"/> </td>
                                    <td>1</td>
                                    <td>Pinki Pachisia</td>
                                    <td>IAS1</td>
                                    <td>Bangalore</td>
                                    <td>560066</td>
                                    <td>India</td>
                                    <td>pinki@ias.com</td>
                                </tr>
                                <tr>
                                    <td> <input class="IASRadioButton" TABINDEX="10" type="radio" name="selectSubcriber"/> </td>
                                    <td>2</td>
                                    <td>Shailendra Mahapatra</td>
                                    <td>IAS2</td>
                                    <td>Bangalore</td>
                                    <td>560067</td>
                                    <td>India</td>
                                    <td>shail@ias.com</td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>


                    <%--Actions--%>

                    <fieldset class="subMainFieldSet">
                        <div class="IASFormFieldDiv">
                            <div id="okBtnDiv">
                                <input class="IASButton" TABINDEX="6" type="submit" value="Ok" name="btnOk"/>
                            </div>
                            <div id="cancelBtnDiv">
                                <input class="IASButton" TABINDEX="8" type="submit" value="Cancel" name="btnCancel" onclick="javascript:window.close()"/>
                            </div>
                        </div>
                    </fieldset>
                </fieldset>
            </div>
        </div>
    </body>
</html>