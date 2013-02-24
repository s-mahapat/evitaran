<%@page session="true" import="org.apache.catalina.Session"%>
<%
    String firstName = null;
    String lastName = null;
    String userPrincipal = null;
    try {
        userPrincipal = request.getUserPrincipal().getName();
        //HttpSession _session = request.getSession(false);

        if (session != null) {
            IAS.Bean.User.LoggedInUserBean _userBean = (IAS.Bean.User.LoggedInUserBean) session.getAttribute("userBean");
            firstName = _userBean.getFirstName();
            lastName = _userBean.getLastName();
        }
    } catch (NullPointerException e) {
        userPrincipal = null;
    }


%>
<div id="header">
    <div id="darksubheader">
        <div id="headertext"><%
            out.println("<img id=\"eVitaran\"" + " src=\"" + request.getContextPath() + "/images/eVitaran.png\"/>");
            %>
        </div>
    </div>
    <div id="lightsubheader">
        <div id="welcomeUser">
            <%
                if (userPrincipal != null) {
                    out.println("Welcome " + firstName + " " + lastName + "!!!");
                    out.println("&nbsp;&nbsp;&nbsp;");
                    out.println("<a href=\"" + request.getContextPath() + "/main?action=logout\"" + "><font color=\"white\">Logout</font></a>");
                } else {
                    response.sendRedirect(request.getContextPath() + "/jsp/login/login.jsp");
                }

            %>
        </div>
        <div id="logoff"></div>
    </div>
    <div id="whitesubheader"></div>
</div>
<div id="iaslogo"></div>
