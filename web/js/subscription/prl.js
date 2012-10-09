/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function GeneratePRLGrid(){
    $("#prlTable").jqGrid({
            url:'subscription?action=prlist',
            datatype: 'xml',
            mtype: 'GET',
            height: 300,
            autowidth: true,
            forceFit: true,
            sortable: false,
            loadonce: true,
            rownumbers: true,
            emptyrecords: "No record(s) to view",
            loadtext: "Loading...",
            colNames:['Subscriber Number','Name','Email','Status'],
            colModel :[
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
                name:'name',
                index:'name',
                width:20,
                align:'center',
                sortable: false,
                xmlmap:'subscriberName'
            },
            {
                name:'email',
                index:'email',
                width:30,
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
                id: "id"
            },
            pager: '#pager',
            rowNum:10,
            rowList:[10,30,50],
            viewrecords: true,
            gridview: true,
            caption: '&nbsp;'
    });
}
