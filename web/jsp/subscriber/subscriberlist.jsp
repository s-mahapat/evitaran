
<script type="text/javascript" src="<%=request.getContextPath()%>/js/city.js"></script>
<script>
    var subscriber = null;
    var selectedSubscriberId = null;
    var selectedsubscriber;
    var isSelected = false;

    $(document).ready(function () {
        // search subscriber when ENTER key is pressed
        setEnterKeyAction(dlg_searchSubscriber);
        //loadCities("<%=request.getContextPath() + "/cities"%>");
        jdsAutoComplete("<%=request.getContextPath() + "/subscriber?action=depts"%>", "department", "department");
        $("#subscriberNumber").focus();

        $("#subscriberList").jqGrid({
            url: "<%=request.getContextPath() + "/subscriber?action=search"%>",
            /*postData: {
             city: subscriber.city,
             subscriberName: subscriber.name,
             country: subscriber.country,
             state: subscriber.state,
             pincode: subscriber.pincode,
             institution: subscriber.institution,
             department: subscriber.department,
             email: subscriber.email
             },*/
            datatype: 'xml',
            mtype: 'GET',
            width: 1000,
            //minWidth: 600,
            height: 260,
            autowidth: true,
            shrinkToFit: true,
            //forceFit: true,
            sortable: true,
            //loadonce: false,
            rownumbers: true,
            //scrollOffset: 0,
            emptyrecords: "No subscribers to view",
            loadtext: "Loading...",
            colNames: ['Select', 'Subscriber Number', 'Subscriber Name', 'Department', 'Institute', 'City', 'Pin Code', 'Country', 'Email'],
            colModel: [
                {name: 'Select', hidden: true, index: 'select', width: 15, align: 'center', xmlmap: 'subscriberNumber'
                            /*formatter:function (cellvalue, options, rowObject) {
                             return '<input onclick="selectedSubscriberId=this.value" type="radio" id="selectedSubscriberRadio" name="selectedSubscriberRadio" value="' + cellvalue + '"/>';
                             }*/
                },
                {name: 'SubscriberNumber', index: 'subscriberNumber', width: 35, align: 'center', sortable: false, xmlmap: 'subscriberNumber'},
                {name: 'SubscriberName', index: 'subscriberName', width: 50, align: 'center', sortable: false, xmlmap: 'subscriberName'},
                {name: 'Department', index: 'department', width: 45, align: 'center', sortable: false, xmlmap: 'department'},
                {name: 'Instituttion', index: 'institute', width: 45, align: 'center', sortable: false, xmlmap: 'institution'},
                {name: 'City', index: 'city', width: 30, align: 'center', sortable: true, sorttype: 'int', xmlmap: 'city'},
                {name: 'PinCode', index: 'pincode', width: 20, align: 'center', sortable: false, xmlmap: 'pincode', formatter: formatpincode},
                {name: 'Country', index: 'country', width: 20, align: 'center', sortable: false, xmlmap: 'country'},
                {name: 'Email', index: 'email', width: 50, align: 'center', sortable: false, xmlmap: 'email'}
            ],
            xmlReader: {
                root: "results",
                row: "row",
                page: "results>page",
                total: "results>total",
                records: "results>records",
                repeatitems: false,
                id: "subscriberNumber"
            },
            pager: '#pager',
            rowNum: 10,
            rowList: [10, 20, 50],
            viewrecords: true,
            gridview: true,
            caption: '&nbsp;',
            onSelectRow: function (rowid, status, e) {
                selectedsubscriber = jQuery("#subscriberList").getRowData(rowid);
            },
            loadComplete: function () {
                $("#subscriberList").jqGrid('setGridWidth', 1150, true);
            }
        });

    });

    function formatpincode(cell, rowid) {
        if (parseInt(cell) === 0) {
            return "";
        }
        return cell;

    }
    
    function dlg_getSelectedSubscriber(){
        return selectedsubscriber;
    }


    // called when the search button is clicked
    function dlg_searchSubscriber() {
        var subscriber = new Object();
        subscriber.city = $("#dlg_city").val();
        subscriber.department = $("#dlg_department").val();
        subscriber.subscriberNumber = $("#dlg_subscriberNumber").val();
        subscriber.subscriberName = $("#dlg_subscriberName").val();
        subscriber.name = $("#dlg_subscriberName").val();
        subscriber.pincode = $("#dlg_pincode").val();
        _dlg_searchSubscriber(subscriber);
    }

    function _dlg_searchSubscriber(subscriber) {

        /*if (dlg_validateSearchSubscriber()) {


        }*/
        jQuery("#subscriberList").setGridParam({mtype: 'POST', postData:
                    {city: subscriber.city,
                        department: subscriber.department,
                        subscriberNumber: subscriber.subscriberNumber,
                        subscriberName: subscriber.subscriberName,
                        pincode: subscriber.pincode,
                        country: subscriber.country,
                        state: subscriber.state,
                        institution: subscriber.institution,
                        email: subscriber.email
                    }});
        jQuery("#subscriberList").trigger("clearGridData");
        jQuery("#subscriberList").trigger("reloadGrid");
    }
    
    function dlg_reset(){
        $("#dlg_subscriberNumber").val("");
        $("#dlg_subscriberName").val("");
        $("#dlg_city").val("");
        $("#dlg_department").val("");
        $("#dlg_pincode").val("");
    }



</script>

<div class="MainDiv">
    <div class="subMainDiv">
        <fieldset class="MainFieldset">
            <legend>Search Subscriber Result</legend>
            <fieldset class="subMainFieldSet">
                <legend>Search Criteria</legend>
                <form method="post" action="" name="searchSubscriberForm" id="searchSubscriberForm">
                    <div class="IASFormLeftDiv">
                        <div class="IASFormFieldDiv">
                            <span class="IASFormDivSpanLabel">
                                <label>Subscriber Number:</label>
                            </span>
                            <span class="IASFormDivSpanInputBox">
                                <input class="IASTextBox" maxlength="11" TABINDEX="1" type="text" name="subscriberNumber" id="dlg_subscriberNumber" value=""/>
                            </span>
                        </div>
                        <div class="IASFormFieldDiv">
                            <span class="IASFormDivSpanLabel">
                                <label>Subscriber Name:</label>
                            </span>
                            <span class="IASFormDivSpanInputBox">
                                <input class="IASTextBoxWide" TABINDEX="2" type="text" name="subscriberName" id="dlg_subscriberName" value=""/>
                            </span>
                        </div>
                        <div class="IASFormFieldDiv">
                            <span class="IASFormDivSpanLabel">
                                <label>City:</label>
                            </span>
                            <span class="IASFormDivSpanInputBox">
                                <input type="text" class="IASTextBox" TABINDEX="3" name="city" id="dlg_city" value=""/>
                            </span>
                        </div>

                    </div>
                    <div class="IASFormRightDiv">
                        <div class="IASFormFieldDiv">
                            <span class="IASFormDivSpanLabel">
                                <label>Department:</label>
                            </span>
                            <span class="IASFormDivSpanInputBox">
                                <input class="IASTextBoxWide" TABINDEX="4" type="text" name="department" id="dlg_department" value=""/>
                            </span>
                        </div>

                        <div class="IASFormFieldDiv">
                            <span class="IASFormDivSpanLabel">
                                <label>Pin Code:</label>
                            </span>
                            <span class="IASFormDivSpanInputBox">
                                <input class="IASTextBox" maxlength="6" TABINDEX="5" type="text" name="pincode" id="dlg_pincode" value=""/>
                            </span>
                        </div>
                    </div>
                    <div class="actionBtnDiv">
                        <input class="IASButton" TABINDEX="6" type="button" value="Search" onclick="dlg_searchSubscriber()" id="btnSearchSubscriber"/>
                        <input class="IASButton" TABINDEX="7" type="reset" value="Reset" onclick="dlg_reset()"/>
                    </div>
            </fieldset>
            </form>
            <fieldset class="subMainFieldSet">
                <legend>Subscriber List</legend>
                <table class="datatable" id="subscriberList"></table>
                <div id="pager"></div>
            </fieldset>

    </div>
</div>
