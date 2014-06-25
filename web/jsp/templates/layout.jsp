<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<div id="ajaxBusy"><img src="${pageContext.request.contextPath}/images/ajax-loader.gif"><p>Please Wait...</p></div>
<div id="user-status-message" style="float: right; right: 5px; bottom: 5px; position: fixed; font-weight: bold;" class="ui-state-error-text ui-state-highlight">
    <%        
        Object msg = request.getAttribute("user-status-message");
        if (request.getAttribute("user-status-message") != null) {
            out.print(msg);
        }
    %>
</div>

