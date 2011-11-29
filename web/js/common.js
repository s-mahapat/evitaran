/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 *use this function to add events to the onload event
 */
function addOnloadEvent(fnc){
    if ( typeof window.addEventListener != "undefined" )
        window.addEventListener( "load", fnc, false );
    else if ( typeof window.attachEvent != "undefined" ) {
        window.attachEvent( "onload", fnc );
    } else {
        if ( window.onload != null ) {
            var oldOnload = window.onload;
            window.onload = function ( e ) {
                oldOnload( e );
                window[fnc]();
            };
        } else
            window.onload = fnc;
    }
}
/*
 * addOnloadEvent(myFunctionName);//
 *  Or to pass argumentsaddOnloadEvent(function(){ myFunctionName('myArgument') });
 */

function checkMandatoryFields(){

    var tagsToValidate = new Array('input', 'select','textarea');
    var isMandatoryFilledFlag = true;

    for (var i=0;i<tagsToValidate.length;i++){
        var allFields = document.getElementsByTagName(tagsToValidate[i]);

        for (var j=0;j<allFields.length;j++){
            if(allFields[j].className == 'IASTextBoxMandatory' ||
                allFields[j].className == 'IASTextAreaMandatory' ||
                allFields[j].className == 'IASComboBoxMandatory' ){

                if (allFields[j].value.length == 0) {
                    var elementID = allFields[j].id;
                    document.getElementById(elementID).style.backgroundColor = 'pink';
                    document.getElementById(elementID).focus();
                    isMandatoryFilledFlag = false;
                //break;
                } else {
                    continue;
                }
            }
        }
    }
    if (isMandatoryFilledFlag == false){
        alert("Please fill in all Mandatory fields. The mandatory fields are marked in RED");
    }
    else{
        return true;
    }
    return false;
}


function openModalPopUp(url){
    result=window.showModalDialog(url,0,"dialogHeight: 500px; dialogWidth: 1100px;center: yes;resizeable: no;status: no;menubar: no;scrollbars: yes;toolbar: no;");
    return result;
}

function openModalPopUpMandatoryReturn(url){
    result=window.showModalDialog(url,1,"dialogHeight: 500px; dialogWidth: 1100px;center: yes;resizeable: no;status: no;menubar: no;scrollbars: yes;toolbar: no;");
    return result;
}

function changePwdDialog(url) {
    result=window.showModalDialog(url,'title',"dialogHeight: 200px; dialogWidth: 200px;center: yes;resizeable: no;status: no;menubar: no;scrollbars: no;toolbar: no;");
}

function isEmpty(element){
    var elValue = element.value;
    if(elValue.length == 0){
        return true;
    }else{
        //check if there are non space characters.
        if(elValue.match(/^\s+$/)){
            return true;
        }
    }
    return false;
}

function trim(s) {
	s = s.replace(/(^\s*)|(\s*$)/gi,"");
	s = s.replace(/[ ]{2,}/gi," ");
	s = s.replace(/\n /,"\n");
	return s;
}

function makeReadOnly(){


    var formFields = document.getElementsByTagName("input");

    for(var i=0;i<formFields.length;i++){
        var formField = formFields[i];
        if( formField.className == "IASTextBox"
            || formField.className == "IASEmailTextBox"
            || formField.className == "IASCheckBox"
            || formField.className == "IASDateTextBox"
            ){
            formField.disabled = true;
        //formField.style.backgroundColor = "#D3D3D3";
        }
    }

    formFields = document.getElementsByTagName("select");

    for(i=0;i<formFields.length;i++){
        formField = formFields[i];
        if(formField.className == "IASComboBox"){
            formField.disabled = true;
        //formField.style.backgroundColor = "#D3D3D3";
        }
    }

    formFields = document.getElementsByTagName("textarea");

    for(i=0;i<formFields.length;i++){
        formField = formFields[i];
        if(formField.className == "IASTextArea"){
            formField.disabled = true;
        //formField.style.backgroundColor = "#D3D3D3";
        }
    }
}

function setActionValue(value){
    var Divs = document.getElementsByTagName('div');
    var mainDiv;
    for(var i=0;i<Divs.length;i++){
        if(Divs[i].className == 'MainDiv'){
            mainDiv = Divs[i];
            break;
        }
    }
    var hiddenInput = document.getElementById('action');
    if( hiddenInput == null){
        hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('type', 'hidden');
        hiddenInput.setAttribute('id', 'action');
        hiddenInput.setAttribute('name', 'action');
        hiddenInput.setAttribute('value', value);
        mainDiv.appendChild(hiddenInput);
    }else{
        document.getElementById('action').value = value;
    }
}

function alert(msg,title){
    if(title == null){
        title = 'Journal Distribution System';
    }
    jAlert(msg,title);
    return false;
}


function jQueryCalendar(divId){

    var div = "#" + divId;
    $(function() {
        $( div ).datepicker({
            showOn: "button",
            dateFormat: 'dd/mm/yy',
            buttonImage: "images/calendar.gif",
            buttonImageOnly: true
        });
    });
}

function jQueryDatePicker(fromDiv, toDiv){

    fromDiv = "#" + fromDiv;
    toDiv = "#" + toDiv;
    dateRangediv = fromDiv + "," + toDiv;

    $(function() {
        var dates = $( dateRangediv ).datepicker({
            //defaultDate: "+1w",
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd/mm/yy',
            numberOfMonths: 3,
            onSelect: function( selectedDate ) {
                var option = this.id == "from" ? "minDate" : "maxDate",
                instance = $( this ).data( "datepicker" ),
                date = $.datepicker.parseDate(
                    instance.settings.dateFormat ||
                    $.datepicker._defaults.dateFormat,
                    selectedDate, instance.settings );
                dates.not( this ).datepicker( "option", option, date );
            }
        });
    });

}