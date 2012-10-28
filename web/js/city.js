function loadCities(url){
    if(typeof url == 'undefined'){
        url = "cities"
    }
    jdsAutoComplete(url, "city", "city");
    $("#city").bind( "autocompletechange", function(event, ui) {
        if(!ui.item){
            alert("Please select item from the list only");
            $(this).val('');
            $(this).focus();
        }
    }); 
}