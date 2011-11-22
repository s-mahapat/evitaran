<%String contextPath = request.getContextPath();%>
<link href="<%=contextPath + "/css/styleforpopup.css" %>" type="text/css" rel="stylesheet"/>
<link rel="icon" href="<%=contextPath + "/images/favicon.ico"%>" type="image/x-icon" />
<link rel="shortcut icon" href="<%=contextPath + "/images/favicon.ico" %>" type="image/x-icon" />
<script src="<%=contextPath + "/js/common.js" %>" type="text/javascript"></script>


<%-- jquery Core --%>
<script src="<%=request.getContextPath() + "/js/jquery/jquery-1.7.min.js"%>" type="text/javascript"></script>

<%-- jquery alerts --%>
<script src="<%=request.getContextPath() + "/js/jquery/jquery.alerts.js"%>" type="text/javascript"></script>
<link href="<%=request.getContextPath() + "/css/jquery/jquery.alerts.css" %>" type="text/css" rel="stylesheet"/>
<%-- jquery ui --%>
<link rel="stylesheet" type="text/css" media="screen" href="<%=request.getContextPath() + "/css/jquery/ui-lightness/jquery-ui-1.8.16.custom.css"%>" />
<link rel="stylesheet" type="text/css" media="screen" href="<%=request.getContextPath() + "/css/jquery/ui.jqgrid.css" %>"/>
<%-- jquery grid --%>
<script src="<%=request.getContextPath() + "/js/jquery/grid.locale-en.js"%>" type="text/javascript"></script>
<script src="<%=request.getContextPath() + "/js/jquery/jquery.jqGrid.min.js"%>" type="text/javascript"></script>