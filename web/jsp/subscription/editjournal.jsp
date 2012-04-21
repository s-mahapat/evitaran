<%--
    Document   : Select Journal
--%>
<%@page import="IAS.Class.util"%>
<script type="text/javascript">
    var journalInfo = {};
    var lastSel = null;
    var journalEdited = 0;

    $(document).ready(function(){

        subscriberType = getSubscriberType($("#subscriberNumber").val());

        $.ajax({
            type: "GET",
            url: "CMasterData?md=journal_groups",
            dataType: "xml",
            success: function(xml){

                $(xml).find("row").each(function(){
                    $(this).find("id").each(function(){
                        groupid = $(this).text();
                    });
                    $(this).find("journalGroupName").each(function(){
                        journalName = $(this).text();
                        $("#journalName").append("<option value='" + groupid + "'>" + journalName + "</option");
                    });
                });
            },
            complete: function(){
                var html=null;
            },
            error: function() {
                alert("XML File could not be found");
            }
        });

        //get the start year and end year key:value pairs for filling the select box
        var szStartYear = null;
        var szEndYear = null;
        $('select#subscriptionStartYear').find('option').each(function() {
            szStartYear = (szStartYear == null) ? $(this).val() + ":" + $(this).val() : szStartYear + ";" + $(this).val() + ":" + $(this).val();
        });

        $('select#endYear').find('option').each(function() {
            szEndYear = (szEndYear == null) ? $(this).val() + ":" + $(this).val() : szEndYear + ";" + $(this).val() + ":" + $(this).val();
        });

        var selectedRowID = null;
        $("#newSubscription").jqGrid({
            url:'subscription?oper=subid&id=' + $("#subscriptionID").val(),
            datatype: 'xml',
            mtype: 'GET',
            height: 180,
            autowidth: true,
            forceFit: true,
            sortable: true,
            loadonce: true,
            rownumbers: true,
            sortname:'journalGroupName',
            emptyrecords: "No subscription(s) to view",
            loadtext: "Loading...",
            colNames: ['ID','Journal Group','Journal Group ID','Journal Cost (INR)','Start Year','End Year','Copies','Total (INR)','Active','Action'],
            colModel: [
                {
                    name:"id",
                    index:"id",
                    align:"center",
                    key: true,
                    width:40

                },
                {
                    name:"journalGroupName",
                    index:"journalGroupName",
                    align:"center",
                    width:140

                },
                {
                    name:"journalGroupID",
                    index:"journalGroupID",
                    align:"center",
                    hidden: true,
                    width:40

                },
                {
                    name:"journalGroupCost",
                    index:"journalGroupCost",
                    align:"center",
                    width:60
                },
                {
                    name:"startYear",
                    index:"startYear",
                    width:60,
                    align:"center",
                    //formatter:"select",
                    editable: true,
                    edittype:'select',
                    editoptions:{value: szStartYear}
                },
                {
                    name:"endYear",
                    index:"endYear",
                    width:60,
                    align:"center",
                    editable: true,
                    edittype:'select',
                    editoptions:{value: szEndYear}

                },
                {
                    name:"copies",
                    index:"copies",
                    width:60,
                    align:"center",
                    editable: true,
                    edittype:'text',
                    editrules: {required: true, minValue: 1, integer: true }
                },
                {
                    name:"total",
                    index:"total",
                    width:60,
                    align:"center"
                },
                {
                    name:"active",
                    index:"active",
                    width:40,
                    align:"center",
                    formatter: "checkbox",
                    editable: true,
                    edittype:'checkbox',
                    editoptions: {value:"true:false"}
                },
                {
                    name:"Action",
                    index:"action",
                    width:20,
                    align:"center",
                    formatter: "actions",
                    formatoptions: {
                        delbutton : false,
                        editformbutton:true,
                        url:"subscription",
                        editOptions: {   modal: true,
                            closeOnEscape: true,
                            url:"subscription",
                            editData: {subtypeid:subscriberType},
                            reloadAfterSubmit: true,
                            recreateForm: true,
                            closeAfterEdit: true,
                            afterSubmit:function(response, postdata){
                                jQuery("#newSubscription").setGridParam({ datatype: "xml" });
                                jQuery("#newSubscription").trigger("reloadGrid");
                                getSubscriptionInfo();
                                if($(response).find("success").text()==1){
                                    return(true);
                                }else{
                                    return(false,"Failed to edit subscription","");
                                }


                                //return()
                            },
                            errorTextFormat:function(){return("Failed to update subscription data");}
                        }
                    }
                }

            ],
            xmlReader : {
                root: "results",
                row: "row",
                repeatitems: false,
                id: "journalGroupName"
            },
            pager: '#pager',
            rowNum:10,
            rowList:[10,20,30],
            gridComplete: function(){

            },
            loadError: function(xhr,status,error){
                alert("Failed getting data from server" + status);
            },
            loadComplete: function(xml){
                var totalSubscriptionValue = 0
                $(xml).find("results").find("row").find("subscriptionTotal").each(function(){
                    totalSubscriptionValue = parseFloat($(this).text()) ;
                });
                //$("#subscriptionTotalValue").val(totalSubscriptionValue);
            }
            /*onSelectRow: function(id){
                selectedRowID = id;
                if(id && id != lastSel){
                    jQuery('#newSubscription').restoreRow(lastSel);
                    lastSel=id;
                }
                var editparameters = {
                    "keys" : true,
                    "oneditfunc" : null,
                    "successfunc" : null,
                    "url" : "subscription",
                    "extraparam" : {subtypeid:subscriberType},
                    "aftersavefunc" : function(){
                        jQuery("#newSubscription").setGridParam({ datatype: "xml" });
                        jQuery("#newSubscription").trigger("reloadGrid");
                        getSubscriptionInfo();
                        //$("#newSubscription").jqGrid.trigger("reloadGrid");
                    },
                    "errorfunc": function(){alert("Failed to update subscription data")},
                    "afterrestorefunc" : null,
                    "restoreAfterError" : true,
                    "mtype" : "POST"
                }
                //jQuery('#newSubscription').editRow(id, editparameters);


            }*/
        }).navGrid('#pager',{add:false, view:false, del:false, edit:true},
        {   modal: true,
            closeOnEscape: true,
            url:"subscription",
            editData: {subtypeid:subscriberType},
            reloadAfterSubmit: true,
            recreateForm: true,
            closeAfterEdit: true,
            afterSubmit:function(response, postdata){
                jQuery("#newSubscription").setGridParam({ datatype: "xml" });
                jQuery("#newSubscription").trigger("reloadGrid");
                getSubscriptionInfo();
                if($(response).find("success").text()==1){
                    return(true);
                }else{
                    return(false,"Failed to edit subscription","");
                }
            },
            errorTextFormat:function(){return("Failed to update subscription data");}
        }, // use default settings for edit
        {}, // use default settings for add
        {},  // delete instead that del:false we need this
        {multipleSearch : true}, // enable the advanced searching
        {closeOnEscape:true} /* allow the view dialog to be closed when user press ESC key*/
    );;
    });




</script>

<fieldset class="subMainFieldSet">
    <legend>Select Journal</legend>

    <div class="IASFormFieldDiv">
        <span class="IASFormDivSpanLabel" style="width:auto;">
            <label>Start Year:</label>
        </span>

        <span class="IASFormDivSpanInputBoxLessMargin">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="subscriptionStartYear" id="subscriptionStartYear" onchange="setEndYear()">
                <%
                    int year = Integer.parseInt(util.getDateString("yyyy"));
                    for (int i = year; i <= year + 4; i++) {
                        out.println("<option value=\"" + i + "\">" + i + "</option>");
                    }
                %>
            </select>
        </span>

        <span class="IASFormDivSpanLabel" style="margin-left:15px;width: auto;">
            <label>End Year:</label>
        </span>

        <span class="IASFormDivSpanInputBoxLessMargin">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="endYear" id="endYear">
                <%
                    for (int j = 0; j <= 4; j++) {
                        out.println("<option value =\"" + (j + year) + "\">" + (j + year) + "</option>");
                    }
                %>
            </select>
        </span>

        <span class="IASFormDivSpanLabel" style="margin-left:15px;width: auto;">
            <label>Journal Price Year:</label>
        </span>

        <span class="IASFormDivSpanInputBoxLessMargin">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="priceYear" id="priceYear">
                <%
                    for (int j = 0; j <= 1; j++) {
                        out.println("<option value =\"" + (year + j) + "\">" + (year + j) + "</option>");
                    }
                %>
            </select>
        </span>

        <span class="IASFormDivSpanLabel" style="margin-left:15px;width: auto;">
            <label>Journal Group</label>
        </span>

        <span class="IASFormDivSpanInputBoxLessMargin">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="journalName" id="journalName">
            </select>
        </span>

        <span class="IASFormDivSpanLabel" style="margin-left:15px;width: auto;">
            <label>Copies:</label>
        </span>

        <span class="IASFormDivSpanInputBoxLessMargin">
            <select class="IASComboBoxMandatory" TABINDEX="11" name="copies" id="copies">
                <%
                    for (int i = 1; i <= 10; i++) {
                        out.println("<option value =\"" + i + "\">" + i + "</option>");
                    }
                %>
            </select>
        </span>
        <span class="IASFormDivSpanInputBox" style="margin-left:35px;">
            <input class="IASButton" TABINDEX="14" type="button" value="Add" id="btnAddLine" name="btnAddLine" onclick="addJournal()"/>
            <%--<input class="IASButton" TABINDEX="15" type="button" value="Delete All" id="btnDeleteAll" name="btnDeleteAll" onclick="deleteRow('All')"/>--%>
        </span>
    </div>
    <div class="IASFormFieldDiv" id="newSubscriptiondiv" style="margin-top: 15px;">
        <table class="datatable" id="newSubscription"></table>
        <div id="pager"></div>
    </div>
    <%--<div id="subscriptionTotal">
        <span>Subscription Total(INR):</span>
        <span id="subscriptionTotalValue">0</span>
    </div>--%>
    <div id="journalGroupContents"></div>
</fieldset>



