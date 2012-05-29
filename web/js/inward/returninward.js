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

    if(document.getElementById("chequeDDReturnReason").value == "NULL"){
        alert("Please select a Cheque/DD reason for return");
        return false;
    }
    return true;
}

function showChequeDDReturnPrintPreview(url){
    //var htmlStr = document.getElementById("returnReasonDiv").outerHTML;
    //$("#printPreview").html(htmlStr);
    //$("#btnPrintPreview").printPreview();
    //windowParameters = "center:yes; resizeable: no;status: no;menubar: no;scrollbars: yes;toolbar: no;";
    _window = window.open(url, "Inward Return");
  
    //$("#chequeReturn").attr("action",url);
    //$("#chequeReturn").submit();
    return true;
}