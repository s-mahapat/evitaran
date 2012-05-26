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
    $("#chequeReturn").attr("action",url);
    $("#chequeReturn").submit();
    return true;
}