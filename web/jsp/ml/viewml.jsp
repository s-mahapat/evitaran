

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../templates/style.jsp"%>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/ml/viewml.css"%>" media="screen"/>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/css/ml/printml.css"%>" media="print"/>
        <title>Print Mailing List</title>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="GET" name="formMailingList">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <fieldset class="subMainFieldSet">
                            <div class="IASFormFieldDiv">
                                <div class="singleActionBtnDiv">
                                    <input class="IASButton" type="button" value="Print Mailing List" onclick="javascript:window.print();"/>
                                </div>
                            </div>
                        </fieldset>
                        <div class="IASFormLeftDiv">
                            <div class="sticker">
                                <div class="stickerAddressDiv">
                                    123 PR/5 2010-2011<br/>
                                    Vivek Gulati<br/>
                                    1975<br/>
                                </div>
                            </div>
                        </div>
                        <div class="IASFormRightDiv">
                            <div class="sticker">
                                <div class="stickerAddressDiv">
                                    123 PR/5 2010-2011<br/>
                                    Ram Kapoor<br/>
                                    175<br/>
                                </div>
                            </div>
                        </div>
                        <div class="IASFormLeftDiv">
                            <div class="sticker">
                                <div class="stickerAddressDiv">
                                    123 PR/5 2010-2011<br/>
                                    Vivek Gulati<br/>
                                    1975<br/>
                                </div>
                            </div>
                        </div>
                        <div class="IASFormRightDiv">
                            <div class="sticker">
                                <div class="stickerAddressDiv">
                                    123 PR/5 2010-2011<br/>
                                    Ram Kapoor<br/>
                                    175<br/>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </form>

        </div>

    </body>
</html>
