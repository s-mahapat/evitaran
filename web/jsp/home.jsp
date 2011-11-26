<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="templates/style.jsp"></jsp:include>
            <title>Home</title>
        </head>
        <body>
        <%@include file="templates/layout.jsp" %>
        <div id="bodyContainer">
            <img id="watermark" src="<%=request.getContextPath() + "/images/watermark.png"%>"/>
        </div>
    </body>
</html>