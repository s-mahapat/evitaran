/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function addOnLoadEvent(fnc){
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

function makeReadOnly(){


    var formFields = document.getElementsByTagName("input");

    for(i=0;i<formFields.length;i++){
        formField = formFields[i];
        if(formField.className == "text"){
            formField.disabled = true;
        //formField.style.backgroundColor = "#D3D3D3";
        }
    }
}


