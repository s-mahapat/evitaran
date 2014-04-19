<%@page session="true" import="org.apache.catalina.Session"%>
<%
    String firstName = null;
    String lastName = null;
    String userPrincipal = null;
    IAS.Bean.User.LoggedInUserBean userBean = null;
    try {
        userPrincipal = request.getUserPrincipal().getName();
        //HttpSession _session = request.getSession(false);

        if (session != null) {
            userBean = (IAS.Bean.User.LoggedInUserBean) session.getAttribute("userBean");
            firstName = userBean.getFirstName();
            lastName = userBean.getLastName();
        }
    } catch (NullPointerException e) {
        //userPrincipal = null;
    }


%>
<div id="header">
    <div id="darksubheader">
        <div id="eVittaran"></div>
    </div>
    <div id="lightsubheader">
        <div id="welcomeUser">
            <%
                if (userPrincipal != null && userBean != null) {
                    out.println("Welcome " + firstName + " " + lastName + "!!!");
                    out.println("&nbsp;&nbsp;&nbsp;");
                    out.println("<a href=\"" + request.getContextPath() + "/main2/logout/do\"" + "><font color=\"white\">Logout</font></a>");
                } else {
                    //response.sendRedirect(request.getContextPath() + "/jsp/login/login.jsp");
                }

            %>
        </div>
        <div id="logoff"></div>
    </div>
    <div id="whitesubheader"></div>
</div>
<div id="iaslogo"></div>
