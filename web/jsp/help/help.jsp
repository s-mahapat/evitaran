<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Help</title>
        <%@include file="../templates/style.jsp" %>
    </head>
    <body>
        <%@include file="../templates/layout.jsp" %>

        <div id="bodyContainer">
            <object width="98%" height="600" type="application/pdf" data="pdfserver?action=printHelp" id="pdf_content">
                <p>Insert your error message here, if the PDF cannot be displayed.</p>
            </object>
        </div>
    </body>
</html>
