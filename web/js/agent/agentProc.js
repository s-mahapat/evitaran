function hideSubsciberFields(){
    $("#lblsubtype").hide();
    $("#subtype").hide();
    $("#subtypecode").hide(); 
    $("#lbldescription").hide();
    $("#subtypedesc").hide();
    $("#lbldeactivate").hide();
    $("#deactive").hide();
    $("#lbldeactivationDate").hide();
    $("#deactivationDate").hide();
    $("#lblsubscriberCreationDate").hide();
    $("#subscriberCreationDate").hide();
    $("#phone").hide();
    $("#fax").hide();
    $("#lblphone").hide();
    $("#lblfax").hide();
}
function makeReadOnlySubscriberFields(){
    $("#city").attr("disabled",true);
    $("#district").attr("disabled",true);
    $("#state").attr("disabled",true);
    $("#country").attr("disabled",true);
    $("#pincode").attr("disabled",true);
    $("#department").attr("disabled",true);
    $("#institution").attr("disabled",true);
    $("#email").attr("disabled",true);
    $("#from").attr("disabled",true);
}

function resetSubscriberFields(){
    $("#city").val("");
    $("#district").val("");
    $("#state").val("");
    $("#country").val("");
    $("#pincode").val("");
    $("#department").val("");
    $("#institution").val("");
    $("#email").val("");
    $("#agent").val("");
    $("#from").val("");
}

function agentXLUpload(){
            
    $(function(){ //Start of main function
        _fileuploader = new jdsfileuploader("uploader");
        _fileuploader.url = "fileupload?action=agentXLValidate";
        _fileuploader.filters = [{
            title : "XLS files", 
            extensions : "xls"
        }];
        _fileuploader.success = function(up, file, info){ //Success block
                    
            var xml = $(info.response);
            var html = "<ol>";
            if(xml.find("rows").size() == 0)
            {
                html += "<hl>There are no errors found. Do you want to upload the excel?</hl>";
            }
            else{
            {
                html += "<hl>Resolve these errors to upload the Excel successfully</hl><br><br>";
            }
            xml.find("rows").each(function(){
                html += "<li>" + $(this).text() + "</li>";
            });
            }
            html += "</ol>";
                    
            $("#ErrorPage").append(html);
                    
            $("#ErrorPage").dialog({ //start of dialog block
                modal: true,
                height: 300,
                width: 500,
                buttons: { //start of buttons block
                    "Upload Excel": function() { //start of upload excel block
                        $.ajax({
                            url: "fileupload?action=agentXLUpload",
                            success:  function(xml){
                                //console.log(xml);
                                drawResultsGrid(xml);
                                $("#btnManualCreation").attr("disabled",true);
                                $("#divManualProc").hide();
                            //function(xml){console.log(xml);}
                            }
                        }); // end of ajax block
                        $( this ).dialog( "close" );
                    }, //end of upload excel block
                    Cancel: function() {
                        $( this ).dialog( "close" );
                    }
                }//start of buttons block
            }); //end of dialog block
        }; // end of Success block
        _fileuploader.error = function(up, args){
            alert("Error in uploading XLS file");
        }
        _fileuploader.draw();
    }); // end of main function
            
    function drawResultsGrid(xml){
        console.log(xml);
        $("#subsTable").jqGrid({
            datastr: xml,
            datatype: 'xmlstring',
            //mtype: 'GET',
            width: '100%',
            height: 240,
            autowidth: true,
            viewrecords: true, 
            forceFit: true,
            sortable: true,
            loadonce: true,
            rownumbers: true,
            emptyrecords: "No records to view",
            loadtext: "Loading...",
            colNames:['Subscriber Number / Subscription Number'],
            colModel :[
            {
                name:'Subscriber Number / Subscription Number', 
                index:'id', 
                align:'center', 
                xmlmap:'id'
            },
            //{name:'Subscription Id', index:'subscriptionid', align:'center', xmlmap:'subscriptionid'}
            ],
            xmlReader : {
                root: "results",
                row: "row",
                //page: "errors>page",
                //total: "errors>total",
                //records : "errors>records",
                repeatitems: false,
                id: "Id"
            },
            pager: '#pager',
            rowNum:10,
            rowList:[10,20,30],
            viewrecords: true,
            gridview: true,
            caption: '&nbsp;',
            //gridComplete: function() {},

            loadError: function(xhr,status,error){
                alert("Failed getting data from server" + status);
            }
        });                         
    }
}
function linktosubscriber(cellvalue, options, rowObject){
    if(cellvalue.length > 0){
        link = "<a style='color:blue;' title='Click here to view subscriber details' href='subscriber?action=display&subscriberNumber=" + cellvalue + "'>" + cellvalue + "</a>";
        return link;
    }
    return cellvalue;
}