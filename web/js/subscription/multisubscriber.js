/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var lastSel = 0;
function drawMultiSubscriberTable(){
    $("#multisubscriberTable").jqGrid({
        url:"",
        datatype: 'local',
        mtype: 'GET',
        //width: '100%',
        height: 300,
        //autowidth: true,
        //forceFit: true,
        sortable: true,
        sortname: '',
        loadonce: false,
        rownumbers: true,
        emptyrecords: "No records to view",
        loadtext: "Loading...",
        colNames:['Subscriber No','Name','Department','Institution','Shipping Address','Invoice Address', 'City', 'District', 'State', 'Country', 'PinCode', 'Email', 'Subscriber Type', 'Subscriber Description', 'Journal', 'Start Year', 'Start Month', 'Period'],
        colModel :[
        {
            name:'subscriberno',
            width:60,
            align:'center',
            editable: true,
            xmlmap:'subscriberno'
        },

        {
            name:'subscribername',
            width:80,
            align:'center',
            editable: true,
            xmlmap:'subscribername'
        },

        {
            name:'department',
            width:40,
            align:'center',
            editable: true,
            xmlmap:'department'
        },

        {
            name:'institution',
            sortable: false,
            width:60,
            align:'center',
            editable: true,
            xmlmap:'institution'
        },

        {
            name:'saddress',
            sortable: false,
            width:80,
            align:'center',
            editable: true,
            xmlmap:'saddress',
            edittype: 'textarea'
        },

        {
            name:'iaddress',
            sortable: false,
            width:60,
            align:'center',
            editable: true,
            xmlmap:'iaddress',
            edittype: 'textarea'
        },

        {
            name:'city',
            sortable: false,
            width:40,
            align:'center',
            editable: true,
            xmlmap:'city',
            //formatter: 'select',
            edittype: 'text',
            editoptions: {dataEvents: 'keydown', fn: function(e){
              alert(e);
            }}

        },

        {
            name:'district',
            sortable: false,
            width:40,
            align:'center',
            editable: true,
            xmlmap:'district'
        },

        {
            name:'state',
            sortable: false,
            width:40,
            align:'center',
            editable: true,
            xmlmap:'state'
        },

        {
            name:'country',
            sortable: false,
            width:50,
            align:'center',
            editable: true,
            xmlmap:'country'
        },

        {
            name:'pincode',
            sortable: false,
            width:60,
            align:'center',
            editable: true,
            xmlmap:'pincode'
        },

        {
            name:'email',
            sortable: false,
            width:60,
            align:'center',
            editable: true,
            xmlmap:'email'
        },

        {
            name:'subtype',
            sortable: false,
            width:60,
            align:'center',
            editable: true,
            xmlmap:'subtype'
        },

        {
            name:'subtypedesc',
            sortable: false,
            width:60,
            align:'center',
            editable: true,
            xmlmap:'subtypedesc'
        },

        {
            name:'journal',
            sortable: false,
            width:60,
            align:'center',
            editable: true,
            xmlmap:'journal'
        },

        {
            name:'startyear',
            sortable: false,
            width:60,
            align:'center',
            editable: true,
            xmlmap:'startyear'
        },

        {
            name:'startmonth',
            sortable: false,
            width:60,
            align:'center',
            editable: true,
            xmlmap:'startmonth'
        },

        {
            name:'years',
            sortable: false,
            width:60,
            align:'center',
            editable: true,
            xmlmap:'years'
        },
        ],
        xmlReader : {
            root: "results",
            row: "row",
            page: "results>page",
            total: "results>total",
            records : "results>records",
            repeatitems: false,
            id: ""
        },
        pager: '#pager_reminders',
        rowNum:15,
        rowList:[15,30,50],
        viewrecords: true,
        gridview: true,
        loadComplete: function(){
            jQuery("#multisubscriberTable").jqGrid('editGridRow', 'new', {
                rowID : 1,
                width: 400,
                modal: true,
                resize: false,
                initdata : {},
                position :"first",
                useDefValues : false,
                useFormatter : false,
                addRowParams : {
                    extraparam:{}
                }
            });
        },
        loadError: function(xhr,status,error){
            alert("Failed getting data from server " + status);
        }
        /*onSelectRow: function(id){
            if(id && id!==lastSel){
                jQuery('#multisubscriberTable').restoreRow(lastSel);
                lastSel=id;
            }
            jQuery('#multisubscriberTable').editRow(id, true);
        }*/
    });
}
