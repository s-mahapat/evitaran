<jsp:useBean class="IAS.Bean.masterdata.priceGroupFormBean" id="priceGroupFormBean" scope="request"></jsp:useBean>
<%-----------------------------------------------------------------------------------------------------%>
<%-- Price Group Field Set --%>
<%-----------------------------------------------------------------------------------------------------%>
<%@page import="IAS.Class.util"%>
<script type="text/javascript">
    var journalInfo = {};
    $(document).ready(function(){

        //jdsAppend("CMasterData?md=journals", "journalName", "journalName");

        $.ajax({
            type: "GET",
            url: "CMasterData?md=journals",
            dataType: "xml",
            success: function(xml){

                $(xml).find("row").each(function(){
                    $(this).find("journalName").each(function(){
                        journalName = $(this).text();
                        $("#journalName").append("<option value='" + journalName + "'>" + journalName + "</option");
                    });
                    $(this).find("journalCode").each(function(){
                        journalCode = $(this).text();
                    });
                    $(this).find("price").each(function(){
                        journalPrice = $(this).text();
                    });
                    // create an array of objects, indexed by the journal name.
                    // the object has details like code and price.
                    journalInfo[journalName] = {code:journalCode,price:journalPrice,discount:10};
                });
            },
            complete: function(){
                var html=null;
            },
            error: function() {
                alert("XML File could not be found");
            }
        });

        $("#journals").jqGrid({
            url:'',
            //data: "subscriberNumber=" + $("#subscriberNumber").val(),
            datatype: 'local',
            mtype: 'GET',
            height: 260,
            autowidth: true,
            forceFit: true,
            sortable: true,
            loadonce: false,
            rownumbers: true,
            sortname:'journalName',
            emptyrecords: "No journal(s) to view",
            loadtext: "Loading...",
            colNames: ['Journal Name','Journal Code','Delete'],
            colModel: [
                {
                    name:"journalName",
                    index:"journalName",
                    align:"center",
                    width:140

                },
                {
                    name:"journalCode",
                    index:"journalCode",
                    align:"center",
                    width:60,
                    key: true
                },
                {
                    name:"delete",
                    index:"delete",
                    width:40,
                    align:"center"
                }

            ],
            caption: '&nbsp;',
            viewrecords: true,
            gridview: true,
            rowNum:20
        });
    });


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
        <div class="IASFormLeftDiv">
            <span class="IASFormDivSpanLabel">
                <label>Journal name:</label>
            </span>

            <span class="IASFormDivSpanInputBoxLessMargin">
                <select class="IASComboBoxMandatory" TABINDEX="11" name="journalName" id="journalName">
                </select>
            </span>
         </div>
         <div class="IASFormrightDiv">
            <div id="addBtnDiv">
                <input onclick="setActionValue('add')"  class="IASButton" TABINDEX="3" type="submit" value="add" id="btnAdd" name="btnSubmitAction"/>
            </div>
         </div>        
     </div>
     <div class="IASFormFieldDiv">
        <table class="datatable" id="journals"></table>
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


