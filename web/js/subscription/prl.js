/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var isPageLoaded = false;
var currentRow = 0;
function GeneratePRLGrid(){
    $("#prlTable").jqGrid({
        url:'subscription?action=genprlist',
        datatype: 'xml',
        mtype: 'GET',
        height: 240,
        autowidth: true,
        forceFit: true,
        sortable: false,
        loadonce: true,
        rownumbers: true,
        emptyrecords: "No record(s) to view",
        loadtext: "Loading...",
        colNames:['Subscriber ID','Subscriber Number','Invoice Number','Amount','Subscriber Name','Subscription ID','End Year','Email','Status'],
        colModel :[
        {
            name:'subid',
            index:'subid',
            width:22,
            align:'center',
            xmlmap:'subscriberID',
            sortable: false
        },
        {
            name:'subno',
            index:'subno',
            width:25,
            align:'center',
            xmlmap:'subscriberNumber',
            sortable: false
        },
        {
            name:'invoiceno',
            index:'invoiceno',
            width:25,
            align:'center',
            xmlmap:'invoiceNumber',
            sortable: false,
            key: true
        },
        {
            name:'amount',
            index:'amount',
            width:15,
            align:'center',
            xmlmap:'amount',
            sortable: false
        },
        {
            name:'name',
            index:'name',
            width:50,
            align:'center',
            sortable: false,
            xmlmap:'subscriberName'
        },
        {
            name:'subscriptionID',
            index:'subscriptionID',
            width:20,
            align:'center',
            sortable: false,
            xmlmap:'subscriptionID'
        },
        {
            name:'endYear',
            index:'endYear',
            width:15,
            align:'center',
            sortable: true,
            xmlmap:'endYear'
        },
        {
            name:'email',
            index:'email',
            width:35,
            align:'center',
            sortable: true,
            xmlmap:'email'
        },
        {
            name:'status',
            index:'status',
            width:20,
            align:'center',
            xmlmap:'by_email',
            sortable: false,
            formatter: emailStatus
        }],
        xmlReader : {
            root: "results",
            row: "row",
            repeatitems: false,
            id: "subid"
        },
        pager: '#pager',
        rowNum:10,
        rowList:[10,30,50],
        viewrecords: true,
        gridview: true,
        caption: '&nbsp;',
        beforeRequest: function(){
            return isPageLoaded;
        },
        loadError: function(xhr,status,error){
            alert("Failed getting data from server " + status);
        },
        gridComplete: function() {
            // get the number of rows in the grid, if its > 0 then only enable the
            // print/email button
            var ids = jQuery("#prlTable").jqGrid('getDataIDs');
            if(ids.length > 0){
                $("#btnprintemail").button("enable");
            }
        }
    });
}

function emailStatus(cellvalue, options, rowObject){
    if(parseInt(cellvalue) == 1){
        return "<label color=\"red\">Success</label>";
    }
    return "<label color=\"red\">Email not sent</label>";

}

function GeneratePRL(){
    jQuery("#prlTable").setGridParam({
        datatype: "xml"
    });
    isPageLoaded = true;
    if(_getMediumSelected() == 0){
        return false;
    }
    jQuery("#prlTable").setGridParam({
        postData:
        {
            medium: $("#prlmedium").val(),
            ctext: $("#ctext").val()
        }
    });
    jQuery("#prlTable").trigger("clearGridData");
    jQuery("#prlTable").trigger("reloadGrid");
    return true;
}

function _getMediumSelected(){
    if($("#prlmedium").val() == 0){
        alert("Please select Email or Print");
        return 0;
    }
    return $("#prlmedium").val();
}

function PrintOrEmail(){
    var medium = $("#prlmedium").val();
    if(medium == 1){
        if(confirm("Do you want to start sending emails now?")){
            _sendEmails();
        }
    }else if(medium == 2 || medium == 3){
        jdsPrint("print/prl/1/" + medium, "Invoice")
    }
}

function _sendEmails(){
    var page = jQuery("#prlTable").jqGrid('getGridParam','page');
    var rows = jQuery("#prlTable").jqGrid('getGridParam','rowNum');
    var totalpages = jQuery("#prlTable").jqGrid('getGridParam','lastpage');

    // for every page
    for(var i=1; i<= totalpages; i++){
        jQuery("#prlTable").jqGrid('setGridParam',{
            page: i
        });
        jQuery("#prlTable").trigger("reloadGrid");
        var invoices = jQuery("#prlTable").jqGrid('getDataIDs');

        // for every row in the page
        for(var row = 0; row < invoices.length; row++){
            var invoiceno = invoices[row];
            var is_success =  jQuery("#prlTable").jqGrid('getCell', invoiceno, "status");

            if(is_success && is_success.toLowerCase() == "success"){
                continue; // if the email was already sent do not send again
            }

            // get the subscriber number
            var subno =  jQuery("#prlTable").jqGrid('getCell', invoiceno, "subno");

            // select the row when sending an email
            jQuery("#prlTable").setSelection(invoiceno,false);

            // send a request to send an email
            _sendEmail("Email/prl/" + invoiceno + "/" + subno, invoiceno);
        }

    }
}

function _sendEmail(url, rowid){
    $.ajax({
        type: "GET",
        url: url, // change to full path of file on server
        dataType: "xml",
        async:   false,
        success: function(xmlResponse){
            $(xmlResponse).find("results").each(function(){
                var isSucess = $(this).find("success").text();
                if(parseInt(isSucess) == 1){
                    jQuery("#prlTable").jqGrid('setRowData', rowid, {
                        'status': "1"
                    });
                }else{
                    jQuery("#prlTable").jqGrid('setRowData', rowid, {
                        'status': "0"
                    });
                }
            });
        },
        complete: function(){

        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert("Failed to send Email. "  + textStatus + ": "+ errorThrown);
        }
    });
}
