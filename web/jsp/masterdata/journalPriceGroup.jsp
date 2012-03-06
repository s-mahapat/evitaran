<jsp:useBean class="IAS.Bean.masterdata.priceGroupFormBean" id="priceGroupFormBean" scope="request"></jsp:useBean>
<%-----------------------------------------------------------------------------------------------------%>
<%-- Price Group Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>
<%@page import="IAS.Class.util"%>

<script type="text/javascript">
           // var selectedJournal = 0;
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(function(){

                $("#journalTable").jqGrid({
                    url:"<%=request.getContextPath() + "/journal?action=search"%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: 240,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: false,
                    rownumbers: true,
                    emptyrecords: "No Journal",
                    loadtext: "Loading...",
                    colNames:['Journal Id','Journal Code','Journal Name','ISSN No', 'View/Edit'],
                    colModel :[
                        {name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        {name:'journalCode', index:'journalCode', width:80, align:'center', xmlmap:'journalCode'},
                        {name:'journalName', index:'journalName', width:80, align:'center', xmlmap:'journalName'},
                        {name:'issnNo', index:'issnNo', width:80, align:'center', xmlmap:'issnNo'},
                        {name:'Action', index:'action', width:80, align:'center',formatter:'showlink'}
                    ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        page: "journal>page",
                        total: "journal>total",
                        records : "journal>records",
                        repeatitems: false,
                        id: "id"
                    },
                    pager: '#pager',
                    rowNum:10,
                    rowList:[10,20,30],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    gridComplete: function() {
                        var ids = jQuery("#journalTable").jqGrid('getDataIDs');

                        for (var i = 0; i < ids.length; i++) {
                            action = "<a style='color:blue;' href='journal?action=edit&id=" + ids[i] + "'>Edit</a>";
                            jQuery("#journalTable").jqGrid('setRowData', ids[i], { Action: action });
                        }
                    },
//                    beforeRequest: function(){
//                        return isPageLoaded;
//                    },
                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server" + status);
                    }

                });

            });

            // called when the search button is clicked



            // called when the search button is clicked
            function searchJournal(){
                if(validateSearchJournal() == true)
                    {
                        isPageLoaded = true;

                        jQuery("#journalTable").setGridParam({postData:
                                {journalCode       : $("#journalCode").val(),
                                journalName          : $("#journalName").val()
                            }});
                        jQuery("#journalTable").setGridParam({ datatype: "xml" });
                        jQuery("#journalTable").trigger("clearGridData");
                        jQuery("#journalTable").trigger("reloadGrid");
                    }
                }

            // draw the date picker.
            //jQueryDatePicker("from","to");

</script>
        
<fieldset class="subMainFieldSet">
    <legend>Group Name</legend>
    <div class="IASFormFieldDiv">
        <div class="IASFormLeftDiv">
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Price Group Id:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBox" TABINDEX="1" readonly="readonly" type="text" name="id" id="id" value="<jsp:getProperty name="priceGroupFormBean" property="id"/>"/>
                </span>
            </div>
        </div>
        <div class="IASFormRightDiv">
            <div class="IASFormFieldDiv">
                <span class="IASFormDivSpanLabel">
                    <label>Price Group Name:</label>
                </span>
                <span class="IASFormDivSpanInputBox">
                    <input class="IASTextBoxMandatory" TABINDEX="2" type="text" name="priceGroupName" id="priceGroupName" value="<jsp:getProperty name="priceGroupFormBean" property="priceGroupName"/>"/>
                </span>
            </div>
        </div>
     </div>
</fieldset>
                    
<fieldset class="subMainFieldSet">
    <legend>Journals</legend>
    <div class="IASFormFieldDiv">
        <table class="datatable" id="journalTable"></table>
        <div id="pager"></div>
     </div>
</fieldset>

<%-----------------------------------------------------------------------------------------------------%>
<%--Price Group Action Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>

<fieldset class="subMainFieldSet">
    <div class="IASFormFieldDiv">
        <input type="hidden" name="action" id="action"/>
        <div id="saveBtnDiv">
            <input onclick="setActionValue('save')"  class="IASButton" TABINDEX="3" type="submit" value="save" id="btnSave" name="btnSubmitAction"/>
        </div>
        <div id="editBtnDiv">
            <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="4" type="submit" value="edit" id="btnEdit" name="btnSubmitAction"/>
        </div>
    </div>
</fieldset>


