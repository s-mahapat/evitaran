<%--
    Document   : Missing Issue List
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../templates/style.jsp"></jsp:include>
            <title>Missing Issue List</title>
            <script>
                $(function(){
                    $(".datatable").jqGrid({
                        url:'/JDS/jsp/missingissue/missingissueXML.jsp',
                        datatype: 'xml',
                        mtype: 'GET',
                        width: '100%',
                        autowidth: true,
                        forceFit: true,
                        sortable: true,
                        loadonce: true,
                        rownumbers: true,
                        emptyrecords: "No records to view",
                        loadtext: "Loading...",
                        colNames:['Year','Month','Journal Name', '#Subscribed Copies','#Copies Sent','Mailing List Gen Date','Action'],
                        colModel :[
                            {name:'Year', index:'year', width:20, align:'center', xmlmap:'year'},
                            {name:'Month', index:'month', width:30, align:'center', xmlmap:'month'},
                            {name:'Journal Name', index:'journal_name', width:60, align:'center', xmlmap:'journal_name'},
                            {name:'#Subscribed Copies', index:'subcribed_copies', width:50, align:'center', sortable: true, sorttype: 'int',xmlmap:'subcribed_copies'},
                            {name:'#Copies Sent', index:'sent_copies', width:50, align:'center', sortable:false, xmlmap:'sent_copies'},
                            {name:'Mailing List Gen Date', index:'mlgen_date', width:50, align:'center', xmlmap:'mlgen_date'},
                            {name:'btnAML', index:'action', width:50, align:'center', xmlmap:'action'},
                        ],
                        xmlReader : {
                            root: "result",
                            row: "missinglist",
                            page: "missingissueXML>page",
                            total: "missinglist>total",
                            records : "missinglist>records",
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
                            var ids = jQuery(".datatable").jqGrid('getDataIDs');
                            for (var i = 0; i < ids.length; i++) {
                                var cl = ids[i];
                                action = "<input type='Button' name='addToMailList' value=\"Add to Mailing List\" onclick=''/>";
                                jQuery(".datatable").jqGrid('setRowData', ids[i], { btnAML: action });
                            }
                        }
                    });
                });
            </script>    
        </head>
        <body>

        <%@include file="../templates/layout.jsp" %>
        <div id="bodyContainer">
            <form method="post" action="<%=request.getContextPath() + "/missingissue"%>" name="missingissueForm">
                <div class="MainDiv">
                    <fieldset class="MainFieldset">
                        <legend>Missing Issue List</legend>
                        <%@include file="subscriberdata.jsp"%>

                        <fieldset class="subMainFieldSet">
                            <legend>Missing Issue List</legend>
                            <table class="datatable" id="missingIssueList"></table>
                            <div id="pager"></div>
                        </fieldset>
                    </fieldset>
                </div>
            </form>
        </div>
    </body>
</html>