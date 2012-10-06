function loadDistricts (){
    jdsAutoComplete("districts", "district", "district");
    $("#district").bind( "autocompleteclose", function(event, ui) {
        onDistrictSelected();        
    });
    
    $("#district").bind( "blur", function(event, ui) {
        if($("#district").val().length > 0){
            checkDistrictSelected(); 
        }
        
    }); 
}
    
    
isDistrictSelected = false;
    
//Handler for AutoCompleter OnClientItemSelected event
function onDistrictSelected() {
    isDistrictSelected = true;
}

//Handler for textbox blur event
function checkDistrictSelected() {
    if (!isDistrictSelected) {                
        alert("Please select item from the list only");
        //$("#district").val("");
    }
    else {
        //reset isDistrictSelected
        isDistrictSelected = false;
    }
}