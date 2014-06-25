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

<script type="text/javascript">
    $(document).ready(function() {
        /*$("#jMenu").jMenu({
         ulWidth: 100,
         effects: {
         effectSpeedOpen: 100,
         effectTypeClose: 'slide'
         },
         animatedText: false
         });*/
        var $menu = $('#ldd_menu');

        /**
         * for each list element,
         * we show the submenu when hovering and
         * expand the span element (title) to 510px
         * http://tympanus.net/codrops/2010/07/14/ui-elements-search-box/
         */
        $menu.children('li:not(.lockdown)').each(function() {
            var $this = $(this);
            var $span = $this.children('span');
            $span.data('width', $span.width());

            $this.bind('mouseenter', function() {
                $menu.find('.ldd_submenu').stop(true, true).hide();
                $span.stop().animate({'width': '510px'}, 200, function() {
                    $this.find('.ldd_submenu').slideDown(200);
                });
            }).bind('mouseleave', function() {
                $this.find('.ldd_submenu').stop(true, true).hide();
                $span.stop().animate({'width': $span.data('width') + 'px'}, 200);
            });
        });

    });
</script>
<%    String contextPath = request.getContextPath();
%>
<div id="menubar">
    <div id="menu">
        <ul id="ldd_menu" class="ldd_menu">            
            <li>
                <span>Subscription</span>
                <div class="ldd_submenu">
                    <ul>
                        <li class="ldd_heading">Inward</li>
                        <li><a href="<%=contextPath + "/main?action=createinward"%>">Create</a></li>
                        <li><a href="<%=contextPath + "/main?action=pendinginwards"%>">Pending</a></li>
                        <li><a href="<%=contextPath + "/main?action=searchinward"%>">Search</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">Subscriber</li>
                        <li><a href="<%=contextPath + "/main?action=searchsubscriber"%>">Search</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">Subscription</li>
                        <li class=""><a tabindex="-1" href="<%=contextPath + "/main?action=prl"%>">Pl. Refer List</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">Mailing List</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=gml"%>">Generate/Print Mailing List</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=vml"%>">View/Print Mailing List</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">Back Issue List</li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=gbil"%>">Generate/Print Back Issue List</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=vbil"%>">View/Print Back Issue List</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">Missing Claims</li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=gmil"%>">Generate/Print Missing Issue</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=vmil"%>">View/Reprint Missing Issue</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">Reminders</li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=sendReminders"%>">Send Reminders</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=displayReminders"%>">Display/Resend Reminders</a></li>
                    </ul>
                </div>
            </li>
            <li>
                <span>Reports</span>
                <div class="ldd_submenu">
                    <ul>
                        <li class="ldd_heading">Master Data</li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=listJournals"%>">List of Journals</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=listSubType"%>">List of Subscriber types</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=listAgent"%>">List of Agent</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=journalRates"%>">Rates for Journals</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=listprintOrder"%>">Print Order</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">Subscriber & Subscription</li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=listSubscriber"%>">List of Subscribers</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=listprofarmaInvoice"%>">List of Invoice</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=listBackissue"%>">List of back issue sent</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=listReminder"%>">List of  renewal reminder sent</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=listmailinglist"%>">List of mailing list sent</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">Others</li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=statement"%>">Statement of Label</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=circulationFigure"%>">Circulation Figures for journals</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=subscriptionFigures"%>">Subscription Figures</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=subscriptionFiguresLegacy"%>">Subscription Figures Legacy</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=listInwards"%>">Inwards</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=outstandingbill"%>">Outstanding Bill</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=listGml"%>">Mailing List</a></li>
                    </ul>
                </div>
            </li>
            <li>
                <span>Master Data</span>
                <div class="ldd_submenu">
                    <ul>
                        <li class="ldd_heading">Country</li>
                        <li><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=addCountry"%>">Add Country</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=searchCountry"%>">Search Country</a></li>
                    </ul>

                    <ul>
                        <li class="ldd_heading">State</li>
                        <li><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=addState"%>">Add State</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=searchstate"%>">Search State</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">District</li>
                        <li><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=addDistrict"%>">Add District</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=searchDistrict"%>">Search District</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">City</li>
                        <li><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=addCity"%>">Add City</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=searchCity"%>">Search City</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">Subscriber</li>
                        <li><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=addSubType"%>">Add New Subscriber Type</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=searchSubType"%>">Search Subscriber Type</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">Journals</li>
                        <li><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=addJournal"%>">Add Journal</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=searchJournal"%>">Search Journal</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=jsGroup"%>">Journal Group</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">Annual Information</li>
                        <li><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=journalDetails"%>">Journal Details</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=journalVolumeDetails"%>">Volume Information</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=subRate"%>">Annual Subscription Rate</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=printOrder"%>">Print Order</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">Agents</li>
                        <li><a tabindex="-1" href="<%=contextPath + "/addMasterData?action=addAgent"%>">Add Agent</a></li>
                        <li><a tabindex="-1" href="<%=contextPath + "/main?action=searchAgent"%>">Search Agent</a></li>
                    </ul>

                </div>
            </li>
            <li>
                <span>Others</span>
                <div class="ldd_submenu">
                    <ul>
                        <li><a href="<%=contextPath + "/main?action=sendBulkEmails"%>">Send Bulk Emails</a></li>
                        <li><a href="<%=contextPath + "/main?action=templates"%>">Templates</a></li>
                        <li><a href="<%=contextPath + "/main?action=help"%>">Help</a></li>
                    </ul>
                    <ul>
                        <li class="ldd_heading">About</li>
                        <li>eVitaran v2.0</li>
                    </ul>
                </div>
            </li>
            <li style="float: right;" class="lockdown">
                <%
                    if (userPrincipal != null && userBean != null) {
                        out.println("<span>");
                        out.println(firstName + " " + lastName + "!!!");
                        out.println("<a href=\"" + request.getContextPath() + "/main2/logout/do\"" + "><font color=\"white\">Logout</font></a>");
                        out.println("</span");
                    }
                %>
            </li>
        </ul>        
    </div>
</div>


