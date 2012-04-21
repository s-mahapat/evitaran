var isPageLoaded = false;
function setSubmitButtonValue(button,value){
    button.value = value;
}

function listSubscription(){
    $(function(){
        //$("#subscriptionDetailDiv").hide();
        $("#subscriptionList").jqGrid({
            url:'subscription?oper=getsubscription&subscriberNumber=' + $("#subscriberNumber").val(),
            datatype: 'xml',
            mtype: 'GET',
            height: 235,
            autowidth: true,
            forceFit: true,
            sortable: true,
            loadonce: true,
            rownumbers: true,
            sortname:'subscriptionID',
            emptyrecords: "No subscription(s) to view",
            loadtext: "Loading...",
            colNames:['Subscription Id','Inward No','Subscription Date','Amount Paid','Subscription Value', 'Balance', 'Currency','Action'],
            colModel :[
            {
                name:'subscriptionID',
                index:'id',
                width:25,
                align:'center',
                xmlmap:'id',
                sortable: true,
                key: true
            },
            {
                name:'inwardNumber',
                index:'inwardNumber',
                width:20,
                align:'center',
                xmlmap:'inwardNumber'
            },

            {
                name:'subscriptionDate',
                index:'subscriptionDate',
                width:30,
                align:'center',
                xmlmap:'subscriptionDate'
            },
            {
                name:'amountPaid',
                index:'amountPaid',
                width:20,
                align:'center',
                xmlmap:'amount'
            },
            {
                name:'subscriptionValue',
                index:'subscriptionValue',
                width:30,
                align:'center',
                xmlmap:'subscriptionTotal'
            },
            {
                name:'balance',
                index:'balance',
                width:20,
                align:'center',
                xmlmap:'balance'
            },
            {
                name:'currency',
                index:'currency',
                width:15,
                align:'center',
                xmlmap:'currency'
            },
            {
                name:'details',
                index:'details',
                width:15,
                align:'center'
            }],
            xmlReader : {
                root: "results",
                row: "row",
                repeatitems: false,
                id: "id"
            },
            pager: '#pager',
            rowNum:10,
            rowList:[10,30,50],
            viewrecords: true,
            gridview: true,
            caption: '&nbsp;',
            gridComplete: function() {

                var ids = jQuery("#subscriptionList").jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    action = "<a style=\"color:blue\" href=\"#\" onclick=\"getSubscriptionDetails(" + ids[i] + ")\">" + "Details" + "</a>";
                    action += "<a style=\"color:blue\" href=\"subscription?action=edit" +
                        "&subscriberNumber=" + $("#subscriberNumber").val() +
                        "&id=" + ids[i] + "\">" + "Edit" + "</a>";
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
   windowParams = "dialogHeight:500px; dialogWidth:800px; center:yes; resizeable:no; status:no; menubar:no;\n\
                    scrollbars:yes; toolbar: no;";
   openModalPopUp("jsp/subscription/subscriptiondetails.jsp?id=" + subscriptionId , "", windowParams);
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
    var _priceDetails = new Array();
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