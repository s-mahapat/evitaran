/*
 * The allusers class is used in fields that have to remain enabled even in readonly mode
 * The reportsdiv class is used for div that are present only for reporting and all button
 * within the div can be enabled safely in readonly mode also
 */
function makeReadOnlyView(){
    $(document).ready(function(){
        $(":input").attr("disabled", true);
        $(":button").button("disable");
        $(".allusers").attr("disabled", false);
        $(".allusers").removeClass("ui-state-disabled");
        $(".reportsdiv input").attr("disabled", false);
        $(".reportsdiv select").attr("disabled", false);
        $(".reportsdiv input").removeClass("ui-state-disabled ui-button-disabled");
    });
}

