var isPageLoaded = false;
function setSubmitButtonValue(button,value){
    button.value = value;
}

function getselected(selectobject) {
    var results = {};
    for (var i=0; i<selectobject.options.length; i++) {
        var option = selectobject.options[i];
        var value = option.value;
        if(option.selected){
            results[option.text] = value;
        }

    }
    return results;
}

function listSubscription(){
    $(function(){
        //$("#subscriptionDetailDiv").hide();
        $("#subscriptionList").jqGrid({
            url:'subscription?oper=getsubscription&subscriberNumber=' + $("#subscriberNumber").val(),
            datatype: 'xml',
            mtype: 'GET',
            height: 255,
            autowidth: true,
            forceFit: true,
            shrinkToFit: true,
            sortable: false,
            loadonce: true,
            rownumbers: true,
            //sortname:'subscriptionID',
            subGrid: true,
            subGridWidth: 20,
            subgridtype: 'xml',
            subGridUrl: 'subscription?oper=detail&subtypeid='+$("#subtypeid").val(),
            subGridOptions: {
                reloadOnExpand: false
            },
            emptyrecords: "No subscription(s) to view",
            loadtext: "Loading...",
            colNames:['Subscription Id','Inward No','Subscription Date','Agent','Discount','Inward Amount','Payments','Total Paid','Subscription Value', 'Balance', 'Legacy Balance','Currency','Action', 'Legacy'],
            colModel :[
            {
                name:'subscriptionID',
                index:'id',
                width:20,
                align:'center',
                xmlmap:'id',
                sortable: false,
                sorttype:'integer',
                key: true
            },
            {
                name:'inwardNumber',
                index:'inwardNumber',
                width:20,
                align:'center',
                sortable: false,
                xmlmap:'inwardNumber'
            },
            {
                name:'subscriptionDate',
                index:'subscriptionDate',
                width:25,
                align:'center',
                sortable: true,
                xmlmap:'subscriptionDate'
            },
            {
                name:'Agent',
                index:'agent',
                width:20,
                align:'center',
                sortable: false,
                xmlmap:'agentName'
            },
            {
                name:'discount',
                index:'discount',
                width:15,
                align:'center',
                sortable: false,
                xmlmap:'discount',
                formatter: function(cellvalue, options, rowObject){
                    if(parseFloat(cellvalue) > 0){
                        return cellvalue + "%";
                    }
                    return cellvalue;
                },
                unformat: function(cellvalue, options){
                    return cellvalue.replace("%","");
                }
            },
            {
                name:'inwardAmount',
                index:'inwardAmount',
                width:25,
                align:'center',
                sortable: false,
                xmlmap:'inwardAmount'
            },
            {
                name:'payment',
                index:'payment',
                width:20,
                align:'center',
                sortable: false,
                xmlmap:'payment'
            /*formatter: paymentInfoLink*/
            },
            {
                name:'amountPaid',
                index:'amountPaid',
                width:15,
                align:'center',
                sortable: false,
                xmlmap:'amountPaid'
            },
            {
                name:'subscriptionValue',
                index:'subscriptionValue',
                width:25,
                align:'center',
                sortable: false,
                xmlmap:'subscriptionTotal'
            },
            {
                name:'balance',
                index:'balance',
                width: 15,
                align:'center',
                sortable: false,
                xmlmap:'balance'
            },
            {
                name:'legacy_balance',
                index:'legacy_balance',
                width: 15,
                align:'center',
                sortable: false,
                hidden: true,
                xmlmap:'legacy_balance'
            },
            {
                name:'currency',
                index:'currency',
                width:15,
                align:'center',
                sortable: false,
                xmlmap:'currency'
            },
            {
                name:'details',
                index:'details',
                width:20,
                align:'center',
                sortable: false
            },
            {
                name:'legacy',
                index:'legacy',
                width:15,
                align:'legacy',
                hidden: true,
                sortable: false
            }],
            subGridModel: [{
                name: ['Journal Group', 'Start Year', 'End Year', 'Start Month','Copies', 'Total', 'Active'],
                width: [120, 40, 40, 40,20, 30, 30],
                align: ['center', 'center', 'center', 'center', 'center', 'center', 'center'],
                mapping: ['journalGroupName', 'startYear', 'endYear', 'startMonth','copies', 'total', 'active'],
                params: ['invoiceid']
            }],
            xmlReader : {
                root: "results",
                row: "row",
                repeatitems: false,
                id: "id",
                subgrid: {
                    root: "results",
                    row: "row",
                    repeatitems: false
                }
            },
            pager: '#pager',
            rowNum:5,
            rowList:[5,10,20],
            viewrecords: true,
            gridview: true,
            //caption: '&nbsp;',
            gridComplete: function() {

                var ids = jQuery("#subscriptionList").jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {

                    var subscription_via_agent = jQuery("#subscriptionList").getCell(ids[i], 'Agent');
                    var islegacy = parseInt(jQuery("#subscriptionList").getCell(ids[i], 'legacy'));
                    var legacy_balance = parseInt(jQuery("#subscriptionList").getCell(ids[i], 'legacy_balance'));
                    var subscription_value = parseFloat(jQuery("#subscriptionList").getCell(ids[i], 'subscriptionValue'));
                    var discount = parseFloat(jQuery("#subscriptionList").getCell(ids[i], 'discount'));

                    // if the agent value is not null then show the subscription value, balance and amount as 0
                    if(subscription_via_agent != ""){
                        jQuery("#subscriptionList").jqGrid('setRowData', ids[i], {
                            "amountPaid": 0
                        });

                        var discounted_price = subscription_value - (discount/100 * subscription_value);
                        var title = discount + "% discount on " + subscription_value;
                        jQuery("#subscriptionList").jqGrid('setRowData', ids[i], {
                            "subscriptionValue": '<a href="#" title="' + title + '">' + discounted_price + '</a>'
                        });

                        jQuery("#subscriptionList").jqGrid('setRowData', ids[i], {
                            "balance": 0
                        });
                    }

                    // if the legacy_balance!=0 then override the balance with legacy_balance
                    if(legacy_balance > 0){
                        jQuery("#subscriptionList").jqGrid('setRowData', ids[i], {
                            "balance": legacy_balance
                        });
                        jQuery("#subscriptionList").jqGrid('setCell', ids[i], 'balance', "", "", {
                            title: 'The balance displayed here comes from the old DBASE system'
                        });
                    }

                    //action = "<a style=\"color:blue\" href=\"#\" onclick=\"getSubscriptionDetails(" + ids[i] + ")\">" + "Details" + "</a>";
                    var action = "";
                    if(islegacy != 1){
                        action = "<a style=\"color:blue\" href=\"subscription?action=edit" +
                        "&subscriberNumber=" + $("#subscriberNumber").val() +
                        "&id=" + ids[i] + "\">" + "Edit" + "</a>";
                    }
                    jQuery("#subscriptionList").jqGrid('setRowData', ids[i], {
                        "details": action
                    });
                }
                isPageLoaded = true;
            }
        });


    });

}

function getSubscriptionDetails(subscriptionId){
    windowParams = "dialogHeight:500px; dialogWidth:1000px; center:yes; resizeable:no; status:no; menubar:no;\n\
                    scrollbars:yes; toolbar: no;";
    openModalPopUp("jsp/subscription/subscriptiondetails.jsp?id=" + subscriptionId + "&subtypeid=" + $("#subtypeid").val() , "", windowParams);
    return false;
}

function setEndYear(){
    var startYear = parseInt($("#subscriptionStartYear").val(),10);
    var html;
    for(i=0;i<=4;i++){
        html += "<option value='" + (startYear+i) + "'>" + (startYear+i) + "</option>";
    }
    $("#endYear").html(html);
}

function getSubscriberType(subscriberNumber){
    var _subscriberType = 0;
    $.ajax({
        type: 'GET',
        dataType: 'xml',
        async: false,
        url: "subscriber?action=getSubscriberType&subscriberNumber=" + subscriberNumber,
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").each(function(){
                _subscriberType = $(this).find("subtype").text();
            });
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to get subscriber type. " + textStatus + ": "+ errorThrown);
        }

    });
    return _subscriberType;
}



function getPrice(startYear, years, journalGroupID, subscriberTypeID){
    var _price = -1;
    var _id = -1;
    //var startMonth = $("#startMonth").val();
    var _priceDetails = new Array();
    /* if the start month is not Jan, then consider it as one year less
     * for e.g. Jul 2012 to Jun 2013, would normally be considered as 2 yrs, but its
     * actually one year. so deduct 1 from the num of years

    if(startMonth > 1){
        years = years - 1;
    }*/

    $.ajax({
        type: 'GET',
        dataType: 'xml',
        async: false,
        url: "subscription?oper=getprice&startyear=" + startYear + "&years=" + years +
        "&journalgroupid=" + journalGroupID + "&subtypeid=" + subscriberTypeID,
        success: function(xmlResponse, textStatus, jqXHR){

            $(xmlResponse).find("results").find("row").each(function(){
                _id = $(this).find("id").text();
            });
            $(xmlResponse).find("results").find("row").each(function(){
                _price = $(this).find("rate").text();
            });
            _priceDetails[0] = _id;
            _priceDetails[1] = _price;
        },
        error: function(jqXHR,textStatus,errorThrown){
            alert("Failed to get Journal Group price. " + textStatus + ": "+ errorThrown);
        }

    });
    return _priceDetails;
}

function paymentInfoLink(cellvalue, options, rowObject){
    var payment_amount = parseInt(cellvalue);
    var link = 0;
    // enable the link only if payment amount > 0
    if(payment_amount > 0){
        var subscription_id = rowObject.childNodes[0].textContent;
        link = '<a href="#" title="Click here for details" onclick="showPaymentInfo(' + subscription_id + ')">' + cellvalue + '</a>';
    }
    return link;
}

function showPaymentInfo(subscription_id){

    var div_id = "#paymentDetails" + subscription_id;
    if($(div_id).length == 0){
        var new_div = "<div id=\"" + div_id + "\"><table id=\"paymentDetailsTable\" class=\"datatable\"></table></div>";
        $("#subscriberDtlsTabs").append(new_div);
    }
    $( div_id ).dialog({
        modal: true,
        width: 800,
        height: 450,
        maxHeight: 500,
        maxWidth: 800,
        position: 'center',
        resizable: false,
        buttons: {
            Ok: function() {
                $( this ).dialog( "close" );
            }
        },
        open: function(){
            drawPaymenDetailstInfo(subscription_id);
        }
    });
}