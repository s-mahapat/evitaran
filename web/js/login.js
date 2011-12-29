/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var bLoginSuccess = false;
var bPasswordSuccess = false;

function init(){

    //document.frmlogin.loginId.focus();
}

function clearErrorMsg(){

    var mdiv = document.getElementById("loginErrorMsg");
    if(!bLoginSuccess){
        mdiv.innerHTML = "&nbsp;";
    }
}

function validateEmail(loginFieldId){
     //var str=document.frmlogin.loginId.value;
     var str= document.getElementById(loginFieldId).value;
     //alert(str);
     //var str=document.form.name.loginId.value;

     if(str.length == 0){
       //  return false;
     }
     var mdiv = document.getElementById("loginErrorMsg");
     var filter=/^.+@.+\..{2,3}$/;
     if (filter.test(str)){
        bLoginSuccess = true;
        mdiv.innerHTML = "&nbsp;";
     }
     else {
        mdiv.innerHTML = "Please enter a valid email address!";
        document.getElementById(loginFieldId).value = "";
        document.getElementById(loginFieldId).focus();
        bLoginSuccess = false;
    }
     return (bLoginSuccess);
}

function validatePassword(passwordField){

    var pwd = document.getElementById(passwordField).value;
    var mdiv = document.getElementById("loginErrorMsg");
    if(pwd.length > 16){
        mdiv.innerHTML = "Please enter a password less than 16 characters !";
        document.getElementById(passwordField).value = "";
        bPasswordSuccess = false;
    }else if(pwd.length == 0){
        mdiv.innerHTML = "Please enter a valid password !";
        bPasswordSuccess = false;
    }else{
        bPasswordSuccess = true;
    }
    return(bPasswordSuccess);
}

function validate(login,password){
    //var mdiv = document.getElementById("loginErrorMsg");
    if(validateEmail(login) && validatePassword(password)){
        return true;
    }else{
        //mdiv.innerHTML = "Please enter a valid Id and Password";
        return false;
    }
}