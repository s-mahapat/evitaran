<script type="text/javascript">
    var myMenu;
    window.onload = function() {
        myMenu = new SDMenu("sidebar");
        myMenu.speed = 3;                     // Menu sliding speed (1 - 5 recomended)
        myMenu.remember = true;               // Store menu states (expanded or collapsed) in cookie and restore later
        myMenu.oneSmOnly = true;             // One expanded submenu at a time
        myMenu.markCurrent = true;            // Mark current link / page (link.href == location.href)

        myMenu.init();
        //myMenu.collapseAll();
        //var homeMenu = myMenu.submenus[0];
        //myMenu.expandMenu(homeMenu);
    }

    // Additional methods...
          // Expand a submenu
    /*myMenu.collapseMenu(firstSubmenu);    // Collapse a menu
    myMenu.toggleMenu(firstSubmenu);      // Expand if collapsed and collapse if expanded

    myMenu.expandAll();                   // Expand all submenus
    myMenu.collapseAll();                 // Collapse all submenus*/

</script>
<div id="sidebar" class="sdmenu">

    <%
        String contextPath = request.getContextPath();
    %>
    <div>
        <span>Home</span>
        <a href="<%=contextPath + "/main?action=home"%>">Home</a>
    </div>
    <div>
        <span>Inward</span>
        <a href="<%=contextPath + "/main?action=createinward"%>">Create Inward</a>
        <a href="<%=contextPath + "/main?action=searchinward"%>">View / Edit Inward</a>
        <a href="<%=contextPath + "/main?action=pendinginwards"%>">Pending Inwards</a>
        <a href="<%=contextPath + "/main?action=newsubscription"%>">New Subscription</a>
        <a href="<%=contextPath + "/main?action=renewsubscription"%>">Renew Subscription</a>
        <a href="<%=contextPath + "/inward/processinward.jsp"%>">Address Change</a>
        <a href="<%=contextPath + "/inward/processinward.jsp"%>">Request for Invoice</a>
        <a href="<%=contextPath + "/inward/processinward.jsp"%>">Missing Issue</a>
        <a href="<%=contextPath + "/inward/processinward.jsp"%>">Reprint</a>

    </div>
    <div>
        <span>Subscriber</span>
        <a href="<%=contextPath + "/main?action=test"%>">View Subscriber</a>
        <a href="<%=contextPath + "/subscriber_subscription.jsp"%>">Edit Subscriber</a>
    </div>
    <div>
        <span>Master Data</span>
        <a href="<%=contextPath + "/main?action=test"%>">Add Subscriber Type</a>
        <a href="<%=contextPath + "/main?action=test"%>">Edit Subscriber Type</a>
        <a href="<%=contextPath + "/main?action=test"%>">Create New Journal</a>
        <a href="<%=contextPath + "/main?action=test"%>">Edit Journal Data</a>
        <a href="<%=contextPath + "/main?action=test"%>">Define Subscription Rates</a>
    </div>
    <div>
        <span>Mailing List</span>
        <a href="<%=contextPath + "/main?action=gml"%>">Generate Mailing List</a>
        <a href="<%=contextPath + "/main?action=gbil"%>">Generate Back Issue List</a>
    </div>
    <div>
        <span>Reports</span>
        <a href="<%=contextPath + "/main?action=test"%>">List of Journals</a>
        <a href="<%=contextPath + "/main?action=test"%>">List of Subscriber Types</a>
        <a href="<%=contextPath + "/main?action=test"%>">List of Agents</a>
        <a href="<%=contextPath + "/main?action=test"%>">List of Subscribers</a>
        <a href="<%=contextPath + "/main?action=test"%>">Circulation figures for Journals</a>
        <a href="<%=contextPath + "/main?action=test"%>">Statement of label for Journals</a>
        <a href="<%=contextPath + "/main?action=test"%>">Proforma Invoice</a>
        <a href="<%=contextPath + "/main?action=test"%>">List of Back Issues Sent</a>
        <a href="<%=contextPath + "/main?action=test"%>">List of Reminders Sent</a>
        <a href="<%=contextPath + "/main?action=test"%>">List of Mailing List Sent</a>
        <a href="<%=contextPath + "/main?action=test"%>">Rates of Journals</a>
    </div>

</div>