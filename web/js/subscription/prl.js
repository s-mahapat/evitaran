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
        height: 350,
        autowidth: true,
        forceFit: true,
        sortable: false,
        loadonce: true,
        rownumbers: true,
        emptyrecords: "No record(s) to view",
        loadtext: "Loading...",
        colNames:['Subscriber ID','Subscriber Number','Invoice Number','Subscriber Name','Subscription ID','End Year','Email','Status'],
        colModel :[
        {
            name:'subid',
            index:'subid',
            width:25,
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
            width:10,
            align:'center',
            sortable: true,
            xmlmap:'endYear'
        },
        {
            name:'email',
            index:'email',
            width:40,
            align:'center',
            sortable: true,
            xmlmap:'email'
        },
        {
            name:'status',
            index:'status',
            width:15,
            align:'center',
            sortable: false
        }],
        xmlReader : {
            root: "results",
            row: "row",
            repeatitems: false,
            id: "subid"
        },
        pager: '#pager',
        rowNum:15,
        rowList:[15,30,50],
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
        _sendEmails();
    }else if(medium == 2 || medium == 3){
        jdsPrint("print/prl/1/" + medium, "Invoice")
    }
}

function _sendEmails(){
    var page = jQuery("#prlTable").jqGrid('getGridParam','page');
    var rows = jQuery("#prlTable").jqGrid('getGridParam','rowNum');
    var totalpages = jQuery("#prlTable").jqGrid('getGridParam','lastpage');

    for(var i=1; i< 3; i++){
        jQuery("#prlTable").jqGrid('setGridParam',{
            page: i
        });
        jQuery("#prlTable").trigger("reloadGrid");
        var invoices = jQuery("#prlTable").jqGrid('getDataIDs');
        for(var row = 0; row < rows; row++){
            var invoiceno = invoices[row];
            jQuery("#prlTable").setSelection(invoiceno,false);
            _sendEmail("Email/prl/" + invoiceno + "/prl", invoiceno);
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
                //console.log(isSucess);
                //alert(rowid);
                if(parseInt(isSucess) == 1){
                    jQuery("#prlTable").jqGrid('setRowData', rowid, {
                        'status': "Success"
                    });
                //alert(rowid);
                //jQuery("#prlTable").setCell(rowid,"status",{'status': "Success"});
                }else{
                    jQuery("#prlTable").setCell(rowid,"status","Fail");
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
