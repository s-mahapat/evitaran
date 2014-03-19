<%@page session="true" import="org.apache.catalina.Session"%>
<%@include file="jquery.jsp" %>
<script>
    $( document ).tooltip();
    $(document).ready(function(){
        $("input:submit, input:button, input:reset, button", "#bodyContainer,.subMainDiv" ).button();
        $(".SaveButton").button({ icons: { primary: "ui-icon-disk"} });
        $(".SearchButton").button({ icons: { primary: "ui-icon-search"} });
        $(".CancelButton").button({ icons: { primary: "ui-icon-circle-close"} });
        $(".PrintButton").button({ icons: { primary: "ui-icon-print"} });
        $(".EmailButton").button({ icons: { primary: "ui-icon-mail-closed"} });
        $(".IASButton").button();
        $("input:reset").on("click", function(){
            resetGrid(".datatable");
        });

        // reste all combo boxes when the esc key is pressed
        $("select[class^=IASCombo]").keydown(function(event){
            if(event.which == 27){
                $("*:focus").val($(this).prop('defaultSelected'));
            }
        });
    });
    $(document).ajaxStart(function(){
        $('#ajaxBusy').show();
    });
    $(document).ajaxStop(function(){
        $('#ajaxBusy').hide();
    });
    $.ajaxSetup({
        cache: false,
        dataType: "xml"
    });
    <%
        String userRole = null;
        try {
            if (session != null) {
                IAS.Bean.User.LoggedInUserBean _userBean = (IAS.Bean.User.LoggedInUserBean) session.getAttribute("userBean");
                userRole = _userBean.getUserRole();
            }
        } catch (NullPointerException e) {
            userRole = null;
        }
    %>

</script>
<link href="<%=request.getContextPath() + "/css/style.css"%>" type="text/css" rel="stylesheet"/>
<%if (userRole != null && userRole.equalsIgnoreCase("monochrome")) {
        out.println("<link href=\"" + request.getContextPath() + "/css/monochrome.css\"" + " type=\"text/css\" rel=\"stylesheet\"/>");
    }
%>
<%if (userRole != null && userRole.equalsIgnoreCase("readonly")) {
        out.println("<script src=\"" + request.getContextPath() + "/js/readonly.js\"" + "></script>");
        out.println("<script>makeReadOnlyView();</script>");
    }
%>