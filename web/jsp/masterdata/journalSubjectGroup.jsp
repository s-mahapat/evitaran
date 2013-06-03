<%--
    Document   : journalSubjectGroup
    Author     : aloko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <link rel="stylesheet" type="text/css" href="css/masterdata/subjectGroup.css"/>
        <title>Journal Groups</title>
        <script type="text/javascript" src="/js/masterdata/journalSubjectGroup.js"></script>
        <script type="text/javascript" src="/js/masterdata/validateJournalSubjectGroup.js"></script>
        <script type="text/javascript" src="js/jquery/grid.common.js"></script>
        <script type="text/javascript" src="js/jquery/grid.inlinedit.js"></script>
        <script type="text/javascript" src="js/jquery/grid.celledit.js"></script>
        <script>
            addOnloadEvent(makeSubjectGroupReadOnly);
        </script>


        <script type="text/javascript">
            var selectedId = 0;
            //initally set to false, after the first search the flag is set to true
            var isPageLoaded = false;

            $(document).ready(function(){
                //jQuery("#journalGroupTable").jqGrid('navGrid',"#IASFormFieldDiv",{edit:false,add:false,del:false});
                jdsAppend("<%=request.getContextPath() + "/CMasterData?md=journalGroupName"%>","journalGroupName","journalGroupName");
                jQuery("#newJournalGroupName").attr("disabled",true);
                jQuery("#btnSave,#btnCancel,#btnEdit").attr("disabled",true);
             });

            $(function(){

                $("#journalGroupTable").jqGrid({
                    url:"<%=request.getContextPath()%>/journalSubjectGroup",
                    datatype: 'xml',
                    mtype: 'GET',
                    width: '100%',
                    height: '240',
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    emptyrecords: "No Journal Groups Found",
                    loadtext: "Loading...",
                    //colNames:['Journal Group Id','Journal Group Name','Journal Name','Select'],
                    colNames:['Journal Name','Select'],
                    colModel :[
                        //{name:'id', index:'id', width:50, align:'center', xmlmap:'id'},
                        //{name:'journalGroupName', index:'journalGroupName', width:50, align:'center', xmlmap:'journalGroupName'},
                        {name:'journalName', index:'journalName', width:80, align:'center', xmlmap:'journalName'},
                        {name:'select', index:'select', width:80, align:'center',xmlmap:'select', editable: true, edittype:'checkbox', editoptions: {value:"Yes:1,No:0"}, formatter: "checkbox"}
                        //, formatoptions: {disabled : false}
                        //{name:'select', index:'select', width:80, align:'center',xmlmap:'select', editable: true, edittype: 'text', editoptions: {rows:"1"}, editrules: {required: true, integer:true, minValue:0 }},
                    ],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        page: "results>page",
                        total: "results>total",
                        records : "results>records",
                        repeatitems: false,
                        id: "id"
                    },
                    pager: '#pager',
                    rowNum:15,
                    rowList:[15,30,45],
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    editurl:"<%=request.getContextPath()%>/journalSubjectGroup?action=save",
                    gridComplete: function() {
                        var ids = jQuery("#journalGroupTable").jqGrid('getDataIDs');

                        for (var i = 0; i < ids.length; i++) {
                            jQuery("#journalGroupTable").jqGrid('setRowData', ids[i]);
                        }
                    },
                    beforeRequest: function(){
                        return isPageLoaded;
                    },
                    loadError: function(xhr,status,error){
                        alert("Failed getting data from server" + status);
                    }

                });

            });

            function edit(){
                var ids = jQuery("#journalGroupTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#journalGroupTable").jqGrid('editRow',ids[i]);
                }
                this.disabled = 'true';
                jQuery("#btnSave,#btnCancel").attr("disabled",false);
            }

            function save(){

                if($("#newJournalGroupName").val() == "")
                {
                    alert("Add a new Journal Group Name");
                }
                else
                {

                    var ids = jQuery("#journalGroupTable").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++)
                    {
                        jQuery("#journalGroupTable").setGridParam({editurl: "<%=request.getContextPath()%>/journalSubjectGroup?action=save" +
                                                    "&newJournalGroupName=" + $("#newJournalGroupName").val() +
                                            "&journalName=" + $("#journalGroupTable").getCell(ids[i], 'journalName')
                                            //"&select=" + $("#journalGroupTable").getCell(ids[i], 'select')
                                            });
                        jQuery("#journalGroupTable").jqGrid('saveRow',ids[i]);
                    }

                    jQuery("#btnSave,#btnCancel,#btnEdit").attr("disabled",true);

                    // Enable select of journal group name from the list box
                    jQuery("#btnSearch").attr("disabled",false);
                    jQuery("#journalGroupName").attr("disabled",false);

                    jQuery("#newJournalGroupName").attr("disabled",true);
                    //jQuery("#btnAdd").attr("disabled",false);
                }
                reloadJournalGroup();
            }

            function cancel(){
                var ids = jQuery("#journalGroupTable").jqGrid('getDataIDs');

                for (var i = 0; i < ids.length; i++) {
                    jQuery("#journalGroupTable").jqGrid('restoreRow',ids[i]);
                }
                jQuery("#btnSave,#btnCancel,#btnEdit").attr("disabled",true);

                jQuery("#btnSearch").attr("disabled",false);
                jQuery("#journalGroupName").attr("disabled",false);

                jQuery("#newJournalGroupName").attr("disabled",true);
            }

            // Called when the user clicks on Add new subject group
            function add(){
                isPageLoaded = true;

                // Enable the text box where the new group name can be added
                jQuery("#newJournalGroupName").val("");
                jQuery("#newJournalGroupName").attr("disabled",false);

                // Disable select of journal group name from the list box
                jQuery("#btnSearch").attr("disabled",true);
                jQuery("#journalGroupName").attr("disabled",true);
                //jQuery("#year").attr("disabled",true);

                // Enable save and cancel buttons
                jQuery("#btnEdit,#btnCancel").attr("disabled",false);
                jQuery("#btnSave").attr("disabled",true);

                // Get the list of journals
                jQuery("#journalGroupTable").setGridParam({postData:
                                {action       : "add"
                            }});
                jQuery("#journalGroupTable").setGridParam({ datatype: "xml" });
                jQuery("#journalGroupTable").trigger("clearGridData");
                jQuery("#journalGroupTable").trigger("reloadGrid");

                // For all the journals disable selection and it should show selected
                var ids = jQuery("#journalGroupTable").jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    jQuery("#journalGroupTable").jqGrid('setRowData', ids[i], { select: {editoptions: {value: true}}});
                    jQuery("#journalGroupTable").jqGrid('setRowData', ids[i], { select: {formatoptions: {disabled: false}}});
                    //$("#jqg_"+ids[i],"#journalGroupTable").attr("readonly",true);
                }
            }

            // Called when the journal group is selected from the list box
            function search(){
                var jgn = $("#journalGroupName").val();
                //if($("#year").val() == 0)
                //alert("Select year");
                if( jgn == 0)
                {
                    alert("Select Journal Group Name");
                }else
                    {
                        isPageLoaded = true;
                        jQuery("#journalGroupTable").setGridParam({postData:
                                {journalGroupName       : $("#journalGroupName").val(),
                                action       : "search"
                            }});

                        jQuery("#journalGroupTable").setGridParam({ datatype: "xml" });
                        jQuery("#journalGroupTable").trigger("clearGridData");
                        jQuery("#journalGroupTable").trigger("reloadGrid");

                        // For all the journals disable selection and it should show selected
                        /*
                        var ids = jQuery("#journalGroupTable").jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            //jQuery("#journalGroupTable").jqGrid('setRowData', ids[i], { select: {editoptions: {value: '1'}}});
                            //jQuery("#journalGroupTable").jqGrid('setRowData', ids[i], { select: {formatoptions: {disabled: true}}});
                            //$("#jqg_"+ids[i],"#journalGroupTable").attr("readonly",true);

                        }*/
                    }
                }


            function reloadJournalGroup(){
                //jQuery("#journalGroupTable").clearGridData();

                $("#journalGroupName").empty();
                $("#journalGroupName").text("");

                var newOption = new Option("Select", "value");
                $(newOption).html("Select");
                $("#journalGroupName").append(newOption);

                requestURL = "/JDS/CMasterData?md=journalGroupName";
                jdsAppend(requestURL,"journalGroupName","journalGroupName");

            }


        </script>
    </head>
    <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <jsp:useBean class="IAS.Bean.masterdata.journalSubjectGroupFormBean" id="journalSubjectGroupFormBean" scope="request"></jsp:useBean>
            <form method="post" action="" name="journalSubjectGroupFormBean" onsubmit="return validatePrintOrder()">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Display Journal Groups</legend>
                            <fieldset class="subMainFieldSet">
                                <legend>Search Criterion</legend>

                                    <div class="IASFormLeftDiv">
                                         <div class="IASFormFieldDiv">
                                            <span class="IASFormDivSpanLabel">
                                                <label>Journal Group:</label>
                                            </span>
                                            <span class="IASFormDivSpanInputBox">
                                                <select class="IASComboBoxWide allusers" TABINDEX="2" name="journalGroupName" id="journalGroupName">
                                                    <option value="0">Select</option>
                                                </select>
                                            </span>
                                        </div>
                                    </div>

                                    <div class="IASFormRightDiv">
                                        <div id="addBtnDiv">
                                             <input class="IASButton allusers" TABINDEX="4" type="button" value="Display Group Contents" id="btnSearch" name="btnSearch" onclick="search()"/>
                                        </div>
                                    </div>
                              </fieldset>

                              <fieldset class="subMainFieldSet">
                                  <legend>Enter New Journal Group Name</legend>
                                    <div class="IASFormLeftDiv">
                                        <div class="IASFormFieldDiv">
                                            <span class="IASFormDivSpanLabel">
                                                <label>Journal Group Name:</label>
                                            </span>
                                            <span class="IASFormDivSpanInputBox">
                                                <input class="IASTextBox" TABINDEX="4" type="text" name="newJournalGroupName" id="newJournalGroupName" value="<jsp:getProperty name="journalSubjectGroupFormBean" property="newJournalGroupName"/>"/>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="IASFormRightDiv">
                                        <div id="addBtnDiv">
                                             <input class="IASButton" TABINDEX="5" type="button" value="Add New Subject Group" id="btnAdd" name="btnAdd" onclick="add()"/>
                                        </div>
                                    </div>
                             </fieldset>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Search Result Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <fieldset class="subMainFieldSet">
                                <legend>Search Result</legend>

                                <table class="datatable" id="journalGroupTable"></table>
                                <div id="pager"></div>
                            </fieldset>
                            <%-----------------------------------------------------------------------------------------------------%>
                            <%-- Journal Actions Field Set --%>
                            <%-----------------------------------------------------------------------------------------------------%>

                            <fieldset class="subMainFieldSet">
                                <div class="IASFormFieldDiv">
                                    <div id="editBtnDiv">
                                        <input class="IASButton" TABINDEX="7" type="button" value="Edit" onclick="edit()" id="btnEdit" name="btnEditAction"/>
                                    </div>
                                    <div id="saveBtnDiv">
                                        <input class="IASButton" TABINDEX="8" type="button" value="Save" onclick="save()" id="btnSave" name="btnSaveAction"/>
                                    </div>
                                    <div id="cancelBtnDiv">
                                        <input class="IASButton" TABINDEX="9" type="button" value="Cancel" onclick="cancel()" id="btnCancel" name="btnCancelAction"/>
                                    </div>
                                </div>
                            </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>

