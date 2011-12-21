<script type="text/javascript">
    var myMenu;
    window.onload = function() {
        myMenu = new SDMenu("sidebar");
        myMenu.speed = 4;
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
        <a tabindex="-1" href="<%=contextPath + "/main?action=home"%>">Home</a>
    </div>
    <div>
        <span>Inward</span>
        <a tabindex="-1" href="<%=contextPath + "/main?action=createinward"%>">Create Inward</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=searchinward"%>">View / Edit Inward</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=pendinginwards"%>">Pending Inwards</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=urn"%>">Update Receipt Numbers</a>

    </div>
    <div>
        <span>Subscriber/Subscription</span>
        <a tabindex="-1" href="<%=contextPath + "/main?action=createsubscriber"%>">Create Subscriber</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=searchsubscriber"%>">Search Subscriber</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=afs"%>">Add Free Subscriber</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=asf"%>">Add Summer Fellows</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=newsubscription"%>">New Subscription</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=renewsubscription"%>">Renew Subscription</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=addresschange"%>">Address Change</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=gpi"%>">Request for Invoice</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=missingissue"%>">Missing Issue</a>
    </div>
    <div>
        <span>Mailing List</span>
        <a tabindex="-1" href="<%=contextPath + "/main?action=gml"%>">Generate Mailing List</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=gbil"%>">Generate Back Issue List</a>
    </div>

    <div>
        <span>Reminders</span>
        <a tabindex="-1" href="<%=contextPath + "/main?action=sendReminders"%>">Send Reminders</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=showSentReminders"%>">Show Sent Reminders</a>
    </div>

    <div>
        <span>Reports</span>
        <a tabindex="-1" href="<%=contextPath + "/main?action=statement"%>">Statement</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=listJournals"%>">List of Journals</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=listSubType"%>">List of Subscriber types</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=listAgent"%>">List of Agent</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=listSubscriber"%>">List of Subscribers</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=circulationFigure"%>">Circulation figures for journals</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=listprofarmaInvoice"%>">List of Invoice</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=listBackissue"%>">List of back issue sent</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=listReminder"%>">List of  renewal reminder sent</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=listmailinglist"%>">List of mailing list sent</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=journalRates"%>">Rates for Journals</a>
    </div>

    <div>
        <span>Master Data</span>
        <a tabindex="-1" href="<%=contextPath + "/main?action=addSubType"%>">Add New Subscriber Type</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=searchSubType"%>">Search Subscriber Type</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=addJournal"%>">Add Journal</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=searchJournal"%>">Search Journal</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=addAgent"%>">Add Agent</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=searchAgent"%>">Search Agent</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=subRate"%>">Annual Subscription Rate</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=addCity"%>">Add City</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=searchCity"%>">Search City</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=addCountry"%>">Add Country</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=searchCountry"%>">Search Country</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=addDistrict"%>">Add District</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=searchDistrict"%>">Search District</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=addState"%>">Add State</a>
        <a tabindex="-1" href="<%=contextPath + "/main?action=searchstate"%>">Search State</a>
    </div>

</div>