<%--
    Document   : Subscription Details
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Subscription Details</title>
        <jsp:include page="../templates/style.jsp"></jsp:include>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#subscriptionDetail").jqGrid({

                    url : "<%=request.getContextPath()%>/subscription?oper=detail&id=<%=request.getParameter("id")%>",
                    datatype: 'xml',
                    mtype: 'GET',
                    height: 240,
                    width: '100%',
                    altRows: false,
                    autowidth: true,
                    forceFit: true,
                    sortable: true,
                    loadonce: true,
                    rownumbers: true,
                    viewrecords: true,
                    gridview: true,
                    caption: '&nbsp;',
                    emptyrecords: "No subscription details",
                    loadtext: "Loading...",
                    colNames:['Journal Group','Start Year','End Year','Copies','Total'],
                    colModel: [
                        {
                            name:"journalGroupName",
                            index:"journalGroupName",
                            align:"center",
                            width:60,
                            key:true
                        },
                        {
                            name:'startYear',
                            index:'startYear',
                            width:60,
                            align:'center',
                            xmlmap:'startYear'
                        },

                        {
                            name:'endYear',
                            index:'endYear',
                            width:60,
                            align:'center',
                            xmlmap:'endYear'
                        },
                        {
                            name:"Copies",
                            index:"Copies",
                            width:60,
                            align:"center",
                            xmlmap: 'copies',
                            editable:true,
                            edittype:'text',
                            editrules:{
                                required: true,
                                integer: true,
                                minValue: 1
                            }
                        },
                        {
                            name:"total",
                            index:"total",
                            width:60,
                            align:"center"
                        }],
                    xmlReader : {
                        root: "results",
                        row: "row",
                        repeatitems: false,
                        id: "id"
                    },
                    pager: '#pager2',
                    rowNum:15,
                    rowList:[15,30,60],
                    beforeRequest:function(){
                        return true;
                    },
                    onSelectRow: function(id){
                        if(id && id!==lastSel){
                            jQuery('#subscriptionDetail').restoreRow(lastSel);
                            lastSel=id;
                        }
                        jQuery('#subscriptionDetail').editRow(id,{
                            keys: true,
                            url: '',
                            succesfunc: function(){},
                            oneditfunc: function() {
                                //alert ("edited");
                            },
                            errorfunc: function(id,response){
                                alert("Error is saving subscription details");
                            }
                        });
                    }
                });
            });

        </script>
    </head>
    <body>
        <div class="subMainDiv">
            <fieldset class="subMainFieldSet">
                <div class="IASFormFieldDiv">
                    <table class="datatable" id="subscriptionDetail"></table>
                    <div id="pager2"></div>
                </div>
            </fieldset>
            <fieldset class="subMainFieldSet">
                <div class="actionBtnDiv">
                    <input onclick="javascript:window.close()" class="IASButton" TABINDEX="1" type="button" value="Close" id="" name=""/>
                </div>
            </fieldset>
        </div>


    </body>
</html>