function enableOtherReason(){
    if(document.getElementById("chequeDDReturnReason").value == "Others"){
        document.getElementById("chequeDDReturnReasonOther").disabled = false;
        document.getElementById("chequeDDReturnReasonOther").focus();
    }
    else{
        document.getElementById("chequeDDReturnReasonOther").value = "";
        document.getElementById("chequeDDReturnReasonOther").disabled = true;
        document.getElementById("reasonText").innerHTML = document.getElementById("chequeDDReturnReason").value;
    }
    $("#btnPrintPreview").button("disable");
    $("#btnEmail").button("disable");
}

function setOtherReturnReason(){
    document.getElementById("reasonText").innerHTML = document.getElementById("chequeDDReturnReasonOther").value;
}

function validate(){
    var rc = checkMandatoryFields(); 
    if(rc){
        if($("#chequeDDReturnReason").val() == "NULL"){
            rc = false;
            alert("Please select a Cheque/DD reason for return");
        }else{
            rc = true
        }
        
    }    
    return rc;
}

function showChequeDDReturnPrintPreview(url){
    //var htmlStr = document.getElementById("returnReasonDiv").outerHTML;
    //$("#printPreview").html(htmlStr);
    //$("#btnPrintPreview").printPreview();
    //windowParameters = "center:yes; resizeable: no;status: no;menubar: no;scrollbars: yes;toolbar: no;";
    _window = window.open(url, "Inward Return");
    _window.onload = function(){
        _window.document.title="Inward Return Print Preview";
    }
  
    //$("#chequeReturn").attr("action",url);
    //$("#chequeReturn").submit();
    return false;
}