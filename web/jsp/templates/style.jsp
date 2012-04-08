
<%--<link href="<%=request.getContextPath() + "/css/sdmenu.css"%>" rel="stylesheet" type="text/css"  />
<script src="<%=request.getContextPath() + "/js/sdmenu/sdmenu.js"%>" type="text/javascript"></script>--%>
<link rel="icon" href="<%=request.getContextPath() + "/images/favicon.ico"%>" type="image/x-icon" />
<link rel="shortcut icon" href="<%=request.getContextPath() + "/images/favicon.ico"%>" type="image/x-icon" />
<script src="<%=request.getContextPath() + "/js/common.js"%>" type="text/javascript"></script>

<%-- jquery Core --%>
<script src="<%=request.getContextPath() + "/js/jquery/jquery-1.7.2.min.js"%>" type="text/javascript"></script>

<%-- jquery alerts --%>
<script src="<%=request.getContextPath() + "/js/jquery/jquery.alerts.js"%>" type="text/javascript"></script>
<link href="<%=request.getContextPath() + "/css/jquery/jquery.alerts.css"%>" type="text/css" rel="stylesheet"/>
<%-- jquery ui --%>
<link rel="stylesheet" type="text/css" media="screen" href="<%=request.getContextPath() + "/css/jquery/redmond/jquery-ui-1.8.18.custom.css"%>" />
<script src="<%=request.getContextPath() + "/js/jquery/jquery-ui-1.8.18.custom.min.js"%>" type="text/javascript"></script>
<%-- jquery grid --%>
<script src="<%=request.getContextPath() + "/js/jquery/grid.locale-en.js"%>" type="text/javascript"></script>
<script src="<%=request.getContextPath() + "/js/jquery/jquery.jqGrid.min.js"%>" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" media="screen" href="<%=request.getContextPath() + "/css/jquery/ui.jqgrid.css"%>"/>

<%-- Block UI --%>
<script src="<%=request.getContextPath() + "/js/jquery/jquery.blockUI.js"%>" type="text/javascript"></script>


<script>
    $(document).ready(function(){
        $( "input:submit, input:button, input:reset, button", "#bodyContainer,.subMainDiv" ).button();
        $("input:reset").on("click", function(){
            resetGrid(".datatable");
        });
    });
</script>
<link href="<%=request.getContextPath() + "/css/style.css"%>" type="text/css" rel="stylesheet"/>
