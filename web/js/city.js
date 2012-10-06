var isCitySelected = false;
function loadCities(){
    jdsAutoComplete("cities", "city", "city");
    $("#city").bind( "autocompleteclose", function(event, ui) {
        onCitySelected();        
    });
    
    $("#city").bind( "blur", function(event, ui) {
        checkCitySelected();        
    });  
}
    
//Handler for AutoCompleter autocompleteselect event
function onCitySelected() {
    isCitySelected = true;    
}

//Handler for textbox blur event
function checkCitySelected() {
    if($("#city").val().length == 0){
        return;
    }
    if (!isCitySelected) {                
        alert("Please select item from the list only");
        $("#city").focus();
        //$("#city").val($("#city").val());
    }
    else {
        //reset isCitySelected
        isCitySelected = false;
    }
}