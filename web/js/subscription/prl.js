/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var isPageLoaded = false;
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
            sortable: false,
            key: true
        },
        {
            name:'subno',
            index:'subno',
            width:25,
            align:'center',
            xmlmap:'subscriberNumber',
            sortable: false,
            key: true
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
            align:'legacy',
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
        }
    });
}

function GeneratePRL(){
    jQuery("#prlTable").setGridParam({ datatype: "xml" });
    isPageLoaded = true;
    if(_getMediumSelected() == 0){
        return false;
    }
    jQuery("#prlTable").setGridParam({
        postData:
        {
            medium: $("#prlmedium").val()
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
        
    }else if(medium == 2 || medium == 3){
        jdsPrint("print/prl/1/" + medium, "Invoice")
    }
}

function _sendEmails(){
    _getRows();
}

function _getRows(){
    var ids = jQuery("#prlTable").jqGrid('getDataIDs');
    for (var i = 0; i < ids.length; i++) {
        var subscriber_id = i;
        var subscription_id = jQuery("#prlTable").getCell(ids[i], 'subscriptionID');
        console.log(subscriber_id);
        console.log(subscription_id);
    }    
}
