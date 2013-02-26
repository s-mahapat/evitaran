<%--
    Document   : Select Journal
--%>
<%@page import="IAS.Class.util"%>
<script type="text/javascript">
    var journalInfo = {};
    $(document).ready(function(){

        //jdsAppend("<%=request.getContextPath() + "/CMasterData?md=month"%>","month","month");
        loadSubscription();
        jdsAppend("<%=request.getContextPath() + "/CMasterData?md=year"%>","year","year");
        //jdsAppend("<%=request.getContextPath() + "/CMasterData?md=journalname"%>","journalName","journalName");

        $("#addmissingissueTable").jqGrid({
            url:'',
            //data: "subscriberNumber=" + $("#subscriberNumber").val(),
            datatype: 'local',
            mtype: 'GET',
            height: 210,
            autowidth: true,
            forceFit: true,
            sortable: true,
            loadonce: false,
            rownumbers: true,
            sortname:'subscriptionDate',
            emptyrecords: "No subscription(s) to view",
            loadtext: "Loading...",
            colNames: ['Subscriber ID', 'Journal Group','Journal Name', 'Volume No', 'Issue', 'Year', 'Subscribed Copies','Missing Copies', 'Delete', ],
            colModel: [
                {
                    name:"subscriptionId",
                    index:"subscriptionId",
                    align:"center",
                    key: true,
                    width:45

                },
                {
                    name:"journalGroupName",
                    index:"journalGroupName",
                    align:"center",
                    key: true,
                    width:120

                },
                {
                    name:"journalName",
                    index:"journalName",
                    align:"center",
                    key: true,
                    width:120

                },
                {
                    name:"volume",
                    index:"volume",
                    width:40,
                    align:"center"
                },
                {
                    name:"issue",
                    index:"issue",
                    width:20,
                    align:"center"
                },
                {
                    name:"year",
                    index:"year",
                    width:20,
                    align:"center"
                },
                {
                    name:"scopies",
                    index:"scopies",
                    width:50,
                    align:"center"
                },
                {
                    name:"mcopies",
                    index:"mcopies",
                    width:45,
                    align:"center"
                },
                {
                    name:"delete",
                    index:"delete",
                    width:20,
                    align:"center"
                }

            ],
            caption: '&nbsp;',
            viewrecords: true,
            gridview: true,
            rowNum:20
        });
    });

    function loadSubscription( ){

                $("#subscriptionId").empty();
                $("#subscriptionId").text("");

                var newOption = new Option("Select", "value");
                $(newOption).html("Select");
                $("#subscriptionId").append(newOption);

                requestURL = "CMasterData?md=get_subscriptionid&mdvalue=" + $("#subscriberNumber").val();

                jdsAppend(requestURL,"id","subscriptionId");

     }

     function loadJournalGroup( ){

                $("#journalGroupName").empty();
                $("#journalGroupName").text("");

                var newOption = new Option("Select", "value");
                $(newOption).html("Select");
                $("#journalGroupName").append(newOption);

                requestURL = "CMasterData?md=get_journalGroup&mdvalue=" + $("#subscriptionId").val();

                jdsAppend(requestURL,"journalGroupName","journalGroupName");

     }

     function loadJournals( ){

                $("#journalName").empty();
                $("#journalName").text("");

                var newOption = new Option("Select", "value");
                $(newOption).html("Select");
                $("#journalName").append(newOption);

                requestURL = "CMasterData?md=get_journalName&mdvalue=" + $("#journalGroupName").val();

                jdsAppend(requestURL,"journalName","journalName");

     }

      function loadMonths( ){

            $("#month").empty();
            $("#month").text("");

            var newOption = new Option("Select", "value");
            $(newOption).html("Select");
            $("#month").append(newOption);

            requestURL = "CMasterData?md=get_month_mi&mdvalue=" + $("#journalName").val() + "&optionalParam=" + $("#year").val();

            jdsAppend(requestURL,"month","month");
     }

    function loadIssues(){
        $("#issue").empty();
        //text("");

        var newOption = new Option("Select", "value");
        $(newOption).html("Select");
        $("#issue").append(newOption);

        requestURL = "/JDS/CMasterData?md=getissues&mdvalue=" +  $("#journalName").val() + "&optionalParam=" +  $("#volume").val();
        jdsAppend(requestURL,"issueNumber","issue");
    }

     function loadvolumes(){
        $("#volume").empty();
        //text("");

        var newOption = new Option("Select", "value");
        $(newOption).html("Select");
        $("#volume").append(newOption);

        requestURL = "/JDS/CMasterData?md=getvolumes&mdvalue=" +  $("#journalName").val() + "&optionalParam=" +  $("#year").val();
        jdsAppend(requestURL,"volumeNumber","volume");
    }

</script>

<fieldset class="subMainFieldSet">
    <legend>Select Journal</legend>
    <div class="IASFormLeftDiv">
        <div class="IASFormFieldDiv">

            <span class="IASFormDivSpanLabel" style="margin-left:15px;width: auto;">
                <label>Subscription:</label>
            </span>

            <span class="IASFormDivSpanInputBoxLessMargin">
                <select class="IASComboBoxMandatory" TABINDEX="1" name="subscriptionId" id="subscriptionId" onchange = "loadJournalGroup()">
                </select>
            </span>

        </div>
        <div class="IASFormFieldDiv">

            <span class="IASFormDivSpanLabel" style="margin-left:15px;width: auto;">
                <label>Journal Group:</label>
            </span>

            <span class="IASFormDivSpanInputBoxLessMargin">
                <select class="IASComboBoxMandatory" TABINDEX="2" name="journalGroupName" id="journalGroupName" onchange = "loadJournals()">
                </select>
            </span>
        </div>
        <div class="IASFormFieldDiv">

            <span class="IASFormDivSpanLabel" style="margin-left:15px;width: auto;">
                <label>Journal Name:</label>
            </span>

            <span class="IASFormDivSpanInputBoxLessMargin">
                <select class="IASComboBoxMandatory" TABINDEX="3" name="journalName" id="journalName" onchange ="loadvolumes()">
                </select>
            </span>
        </div>

    </div>

    <div class="IASFormRightDiv">

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Year:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="4" name="year" id="year" onchange="loadvolumes()">
                </select>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Volume Number:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="5" name="volume" id="volume" onchange="loadIssues()">
                    <option value="0">Select</option>
                </select>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Issue:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <select class="IASComboBox" TABINDEX="6" name="issue" id="issue">
                    <option value="0">Select</option>
                </select>
            </span>
        </div>

        <div class="IASFormFieldDiv">
            <%--<span class="IASFormDivSpanLabel" style="margin-left:15px;width: auto;">--%>
            <span class="IASFormDivSpanLabel">
                <label>Missing Copies:</label>
            </span>
            <span class="IASFormDivSpanInputBox">
                <input class="IASTextBox" TABINDEX="7" type="text" name="missingcopies" id="missingcopies" value=""/>
            </span>
        </div>
    </div>

    <span class="actionBtnDiv" style="margin-left:5px;">
        <input class="IASButton" TABINDEX="8" type="button" value="Add" id="btnAddLine" name="btnAddLine" onclick="addJournal()"/>
        <input class="IASButton" TABINDEX="9" type="button" value="Delete All" id="btnDeleteAll" name="btnDeleteAll" onclick="deleteRow('All')"/>
    </span>

    <div class="IASFormFieldDiv" id="addmissingissueTablediv" style="margin-top: 15px;">
        <table class="datatable" id="addmissingissueTable"></table>
        <div id="pager"></div>
    </div>
</fieldset>



