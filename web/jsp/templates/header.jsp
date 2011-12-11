<%@page session="true" import="org.apache.catalina.Session"%>
<div id="header">
    <div id="darksubheader">
        <div id="headertext">Journal Distribution System  </div>
    </div>
    <div id="lightsubheader">
        <div id="smalldarksubheader"></div>
        <div id="welcomeUser">
        <%
            String userPrincipal = null;
            try{
                userPrincipal = request.getUserPrincipal().getName();

            }
            catch(NullPointerException e){
                userPrincipal = null;
            }
            finally{
                if(userPrincipal != null){
                    out.println("Welcome " + userPrincipal + " !");
                    out.println("<a href=" + request.getContextPath() + "/main?action=logout" + ">Logout</a>");
                }else{
                    response.sendRedirect(request.getContextPath() + "/jsp/login/login.jsp");
                }
            }

        %>
        </div>
    </div>
    <div id="whitesubheader"></div>
</div>
<div id="iaslogo"></div>
