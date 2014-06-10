<%--
    Document   : Select Journal
--%>
<%@page import="IAS.Class.util"%>
<script type="text/javascript">
    var journalInfo = {};
    var lastSel = null;
    var journalEdited = 0;

    $(document).ready(function() {

        subscriberType = getSubscriberType($("#subscriberNumber").val());
    <%-- disable and hide the delete all button here, its not required here
    in the edit subscription screen. Its part of selectjournal
    and is used for addnewsubscription.since the same jsp is used here also we need to disable that--%>
        $("#btnDeleteAll").button("disable");
        $("#btnDeleteAll").hide();

        $.ajax({
            type: "GET",
            url: "CMasterData?md=journal_groups",
            dataType: "xml",
            success: function(xml) {

                $(xml).find("row").each(function() {
                    $(this).find("id").each(function() {
                        groupid = $(this).text();
                    });
                    $(this).find("journalGroupName").each(function() {
                        journalName = $(this).text();
                        $("#journalName").append("<option value='" + groupid + "'>" + journalName + "</option");
                    });
                });
                $("#journalName").multiselect({
                    noneSelectedText: 'Select Journals',
                    height: 300,
                    selectedList: 2,
                    selectedText: "# of # selected"
                });
            },
            complete: function() {
                var html = null;
            },
            error: function() {
                alert("XML File could not be found");
            }
        });

        //get the start year and end year key:value pairs for filling the select box
        var szStartYear = null;
        var szEndYear = null;
        var szStartMonth = null;
        var szCopies = null;
        $('select#subscriptionStartYear').find('option').each(function() {
            szStartYear = (szStartYear == null) ? $(this).val() + ":" + $(this).val() : szStartYear + ";" + $(this).val() + ":" + $(this).val();
        });

        /*$('select#endYear').find('option').each(function() {
         szEndYear = (szEndYear == null) ? $(this).val() + ":" + $(this).val() : szEndYear + ";" + $(this).val() + ":" + $(this).val();
         });*/

        $('select#startMonth').find('option').each(function() {
            szStartMonth = (szStartMonth == null) ? $(this).val() + ":" + $(this).text() : szStartMonth + ";" + $(this).val() + ":" + $(this).text();
        });

        $('select#copies').find('option').each(function() {
            szCopies = (szCopies == null) ? $(this).val() + ":" + $(this).text() : szCopies + ";" + $(this).val() + ":" + $(this).text();
        });

        var selectedRowID = null;
        $("#newSubscription").jqGrid({
            url: 'subscription?oper=subid&id=' + $("#subscriptionID").val() + "&subtypeid=" + $("#subtypeid").val(),
            datatype: 'xml',
            mtype: 'GET',
            height: 240,
            autowidth: true,
            forceFit: true,
            sortable: true,
            loadonce: true,
            rownumbers: true,
            sortname: 'journalGroupName',
            emptyrecords: "No subscription(s) to view",
            loadtext: "Loading...",
            colNames: ['ID', 'Journal Group', 'Journal Group ID', 'Journal Cost (INR)', 'Start Year', 'Start Month', 'End Year', 'Copies', 'Total (INR)', 'Active', 'Action'],
            colModel: [
                {
                    name: "id",
                    index: "id",
                    align: "center",
                    key: true,
                    width: 40

                },
                {
                    name: "journalGroupName",
                    index: "journalGroupName",
                    align: "center",
                    width: 140

                },
                {
                    name: "journalGroupID",
                    index: "journalGroupID",
                    align: "center",
                    hidden: true,
                    width: 40

                },
                {
                    name: "journalGroupCost",
                    index: "journalGroupCost",
                    align: "center",
                    width: 60
                },
                {
                    name: "startYear",
                    index: "startYear",
                    width: 40,
                    align: "center",
                    //formatter:"select",
                    editable: true,
                    edittype: 'select',
                    editoptions: {value: szStartYear}
                },
                {
                    name: "startMonth",
                    index: "startMonth",
                    width: 40,
                    align: "center",
                    formatter: monthNumberToName,
                    unformat: monthNameToNumber,
                    editable: true,
                    edittype: 'select',
                    editoptions: {value: szStartMonth}
                },
                {
                    name: "endYear",
                    index: "endYear",
                    width: 30,
                    align: "center",
                    editable: true,
                    edittype: 'select',
                    editoptions: {value: get_current_year}

                },
                {
                    name: "copies",
                    index: "copies",
                    width: 30,
                    align: "center",
                    editable: true,
                    edittype: 'text',
                    editoptions: {value: szCopies},
                    editrules: {required: true, minValue: 1, integer: true}
                },
                {
                    name: "total",
                    index: "total",
                    width: 40,
                    align: "center"
                },
                {
                    name: "active",
                    index: "active",
                    width: 40,
                    align: "center",
                    formatter: "checkbox",
                    editable: true,
                    edittype: 'checkbox',
                    editoptions: {value: "true:false"}
                },
                {
                    name: "Action",
                    index: "action",
                    width: 20,
                    align: "center",
                    formatter: "actions",
                    formatoptions: {
                        delbutton: false,
                        editformbutton: true,
                        url: "subscription",
                        editOptions: {modal: true,
                            closeOnEscape: true,
                            url: "subscription",
                            editData: {subtypeid: subscriberType},
                            reloadAfterSubmit: true,
                            recreateForm: true,
                            closeAfterEdit: true,
                            beforeSubmit: function(postdata, formid) {
                                var subscriberTypeID = $("#subtypeid").val();
                                // get the selected row
                                var rowid = jQuery("#newSubscription").jqGrid('getGridParam', 'selrow');

                                // get the journal group id
                                var journalGroupID = jQuery("#newSubscription").jqGrid('getCell', rowid, 'journalGroupID');
                                var _startyr = parseInt(postdata.startYear);
                                var _endyr = parseInt(postdata.endYear);
                                var _startmonth = parseInt(postdata.startMonth);
                                var _years = _endyr - _startyr + 1;
                                // handle the case if startmonth is > Jan
                                if (_startmonth > 1) {
                                    _years = _endyr - _startyr;
                                }

                                // get the price of the edited data, do not allow to save if invalid
                                var price = getPrice(_startyr, _years, journalGroupID, subscriberTypeID);
                                if (price[0] > -1) {
                                    return([true, ""]);
                                } else {
                                    return([false, "Invalid subscription. Check subscription period"]);
                                }
                            },
                            afterSubmit: function(response, postdata) {
                                jQuery("#newSubscription").setGridParam({datatype: "xml"});
                                jQuery("#newSubscription").trigger("reloadGrid");
                                getSubscriptionInfo();
                                if ($(response).find("success").text() == 1) {
                                    return(true);
                                } else {
                                    return(false, "Failed to edit subscription", "");
                                }


                                //return()
                            },
                            errorTextFormat: function() {
                                return("Failed to update subscription data");
                            }
                        }
                    }
                }

            ],
            xmlReader: {
                root: "results",
                row: "row",
                repeatitems: false,
                id: "journalGroupName"
            },
            pager: '#pager',
            rowNum: 10,
            rowList: [10, 20, 30],
            gridComplete: function() {

            },
            loadError: function(xhr, status, error) {
                alert("Failed getting data from server" + status);
            },
            loadComplete: function(xml) {
                var totalSubscriptionValue = 0
                $(xml).find("results").find("row").find("subscriptionTotal").each(function() {
                    totalSubscriptionValue = parseFloat($(this).text());
                });
                //$("#subscriptionTotalValue").val(totalSubscriptionValue);
            }
        }).navGrid('#pager', {add: false, view: false, del: false, edit: true},
        {modal: true,
            closeOnEscape: true,
            url: "subscription",
            editData: {subtypeid: subscriberType},
            reloadAfterSubmit: true,
            recreateForm: true,
            closeAfterEdit: true,
            afterSubmit: function(response, postdata) {
                jQuery("#newSubscription").setGridParam({datatype: "xml"});
                jQuery("#newSubscription").trigger("reloadGrid");
                getSubscriptionInfo();
                if ($(response).find("success").text() == 1) {
                    return(true);
                } else {
                    return(false, "Failed to edit subscription", "");
                }
            },
            errorTextFormat: function() {
                return("Failed to update subscription data");
            }
        }, // use default settings for edit
        {}, // use default settings for add
                {}, // delete instead that del:false we need this
                {multipleSearch: true}, // enable the advanced searching
        {closeOnEscape: true} /* allow the view dialog to be closed when user press ESC key*/
        );

        function get_current_year(elem) {
            var rowid = jQuery("#newSubscription").jqGrid('getGridParam', 'selrow');
            var endYear = jQuery("#newSubscription").jqGrid('getCell', rowid, 'endYear');
            if (szStartYear.indexOf(endYear) < 0) {
                szEndYear = szStartYear + ";" + endYear + ":" + endYear;
            }
            else{
                szEndYear = szStartYear; 
            }
            return szEndYear;
        }


    });




</script>

<fieldset class="subMainFieldSet">
    <legend>Select Journal</legend>
    <%@include file="selectjournal.jsp" %>

    <div class="IASFormFieldDiv" id="newSubscriptiondiv" style="margin-top: 15px;">
        <table class="datatable" id="newSubscription"></table>
        <div id="pager"></div>
    </div>
    <div id="journalGroupContents"></div>
</fieldset>



