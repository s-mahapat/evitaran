function loadCities(url){
    if(typeof url == 'undefined'){
        url = "cities"
    }
    jdsAutoComplete(url, "city", "city");
    $("#city").bind( "autocompletechange", function(event, ui) {
        if(!ui.item){
            $(this).val('');
            $("#city").focus();
            alert("Please select item from the list only");
        }
    });
}