<link href="<%=request.getContextPath() + "/menu/css/dcaccordion.css"%>" rel="stylesheet" type="text/css"  />
<link href="<%=request.getContextPath() + "/menu/css/skins/grey.css"%>" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath() + "/menu/js/jquery.dcjqaccordion.2.7.min.js"%>" type="text/javascript"></script>
<script src="<%=request.getContextPath() + "/menu/js/jquery.cookie.js"%>" type="text/javascript"></script>
<script>
    $(document).ready(function($){
        $('#accordion-1').dcAccordion({
            eventType: 'click',
            autoClose: true,
            saveState: true,
            disableLink: true,
            speed: 'fast',
            showCount: false,
            autoExpand: true,
            cookie	: 'dcjq-accordion-1',
            classExpand	 : 'dcjq-current-parent'
        });
    });
</script>
<div id="sidebar" class="grey">

    <%
        String contextPath = request.getContextPath();
    %>
    <ul class="accordion" id="accordion-1">
        <li class="menu"><a tabindex="-1" href="<%=contextPath + "/main?action=home"%>">Home</a>
            <!--<ul>
                <li class="menuitem">
                    <a tabindex="-1" href="<%=request.getContextPath()%>/main?action=logout">Logout</a>
                </li>
            </ul>-->
        </li>
        <li class="menu"><a href="#">Inward</a>
            <ul>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=createinward"%>">Create Inward</a></li>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=searchinward"%>">View / Edit Inward</a></li>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=pendinginwards"%>">Pending Inwards</a></li>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=urn"%>">Update Receipt Numbers</a></li>
            </ul>
        </li>
        <li class="menu"><a href="#">Subscriber <br> Subscription</a>
            <ul>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=gcreatesubscriber"%>">Create Subscriber</a></li>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=searchsubscriber"%>">Search Subscriber</a></li>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=afs"%>">Add Free Subscriber</a></li>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=asf"%>">Add Summer Fellows</a></li>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=searchsubscriber"%>">Subscription</a></li>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=newsubscription"%>">New Subscription</a></li>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=renewsubscription"%>">Renew Subscription</a></li>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=addresschange"%>">Address Change</a></li>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=gpi"%>">Request for Invoice</a></li>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=missingissue"%>">Missing Issue</a></li>
            </ul>

        </li>
        <li class="menu"><a href="#">Mailing List</a>
            <ul>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=gml"%>">Generate Mailing List</a></li>
                <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=gbil"%>">Generate Back Issue List</a></li>
            </ul>

        </li>
        <li class="menu">
            <a href="#">Reminders</a>
            <ul>
                <li class="menuitem">
                    <a tabindex="-1" href="<%=contextPath + "/main?action=sendReminders"%>">Send Reminders</a>
                </li>
            </ul>
        </li>

        <li class="menu"><a href="#">Reports</a>
            <ul>
                <li class="menu"><a href="#">Master Data</a>
                    <ul>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=listJournals"%>">List of Journals</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=listSubType"%>">List of Subscriber types</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=listAgent"%>">List of Agent</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=journalRates"%>">Rates for Journals</a></li>
                    </ul>
                </li>
                <li class="menu"><a href="#">Subscriber/ Subscription</a>
                    <ul>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=listSubscriber"%>">List of Subscribers</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=listprofarmaInvoice"%>">List of Invoice</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=listBackissue"%>">List of back issue sent</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=listReminder"%>">List of  renewal reminder sent</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=listmailinglist"%>">List of mailing list sent</a></li>
                    </ul>
                </li>
                <li class="menu"><a href="#">Others</a>
                    <ul>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=statement"%>">Statement</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=circulationFigure"%>">Circulation figures for journals</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=listInwards"%>">Inwards</a></li>
                    </ul>
                </li>
            </ul>
        </li>

        <li class="menu"><a href="#">Master Data</a>
            <ul>
                <li class="menu"><a href="#">Country</a>
                    <ul>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=addCountry"%>">Add Country</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=searchCountry"%>">Search Country</a></li>
                    </ul>
                </li>
                <li class="menu"><a href="#">State</a>
                    <ul>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=addState"%>">Add State</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=searchstate"%>">Search State</a></li>
                    </ul>
                </li>
                <li class="menu"><a href="#">District</a>
                    <ul>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=addDistrict"%>">Add District</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=searchDistrict"%>">Search District</a></li>
                    </ul>
                </li>
                <li class="menu"><a href="#">City</a>
                    <ul>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=addCity"%>">Add City</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=searchCity"%>">Search City</a></li>
                    </ul>
                </li>
                <li class="menu"><a href="#">Subscriber</a>
                    <ul>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=addSubType"%>">Add New Subscriber Type</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=searchSubType"%>">Search Subscriber Type</a></li>
                    </ul>
                </li>
                <li class="menu"><a href="#">Journals</a>
                    <ul>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=addJournal"%>">Add Journal</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=searchJournal"%>">Search Journal</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=jsGroup"%>">Journal Subject Group</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=subRate"%>">Annual Subscription Rate</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=printOrder"%>">Print Order</a></li>
                    </ul>
                </li>
                <li class="menu"><a href="#">Agents</a>
                    <ul>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=addAgent"%>">Add Agent</a></li>
                        <li class="menuitem"><a tabindex="-1" href="<%=contextPath + "/main?action=searchAgent"%>">Search Agent</a></li>
                    </ul>
                </li>
            </ul>

        </li>
    </ul>
    <div id="verticalwhiteline"></div>
</div>