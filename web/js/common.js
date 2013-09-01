function validateEmail(FieldId) {
    var isValidEmail = false;
    var str = document.getElementById(FieldId).value;
    if (str.length == 0) {
        isValidEmail = true;
    }
    var filter = /^.+@.+\..{2,3}$/;
    if (filter.test(str)) {
        isValidEmail = true;
    }
    if (!isValidEmail) {
        alert("Please input a valid email address!");
        document.getElementById(FieldId).value = "";
        document.getElementById(FieldId).focus();
    }

}

function checkMandatoryFields() {
    var _filled = false;
    _filled = _checkMandatoryFields();

    if (!_filled) {
        alert("Please fill all mandatory fields to proceed");
    }
    return _filled;
}

function _checkMandatoryFields() {
    var _filled = true;
    var _classToValidate = new Array("IASTextBoxMandatory", "IASTextBoxMandatoryWide", "IASTextAreaMandatory", "IASComboBoxMediumMandatory", "IASComboBoxSmallMandatory", "IASComboBoxMandatory");
    $(_classToValidate).each(function(index, el) {
        var _elements = $("." + el);
        $(_elements).each(function(index, el) {
            if ($("#" + el.id).val().length == 0) {
                _filled = false;
                return;
            }
        });
        if (!_filled) {
            return; // return immediately if the inner function found a mandatory field not filled.
        }
    });

    return _filled;
}


function openModalPopUp(url, dialogArgs, windowParameters) {
    if (windowParameters == undefined) {
        var width = 1200;
        var height = 650;
        var x = (window.screen.availWidth - width) / 2;
        var y = (window.screen.availHeight - height) / 2;
        windowParameters = "dialogHeight: " + height + "px; dialogWidth: " + width + "px; dialogTop:" + y + "px; dialogLeft:" + x + "px; center:no; resizeable: no; location:no; status:no; menubar: no; scrollbars: no; toolbar: no";
    }
    result = window.showModalDialog(url, dialogArgs, windowParameters);
    return result;
}

function openModalPopUpMandatoryReturn(url) {
    result = window.showModalDialog(url, 1, "dialogHeight: 500px; dialogWidth: 1100px;center: yes;resizeable: no;status: no;menubar: no;scrollbars: yes;toolbar: no;");
    return result;
}

function changePwdDialog(url) {
    result = window.showModalDialog(url, 'title', "dialogHeight: 200px; dialogWidth: 200px;center: yes;resizeable: no;status: no;menubar: no;scrollbars: no;toolbar: no;");
}

function isEmpty(element) {
    var elValue = element.value;
    if (elValue.length == 0) {
        return true;
    } else {
        //check if there are non space characters.
        if (elValue.match(/^\s+$/)) {
            return true;
        }
    }
    return false;
}

function isEmptyValue(evalue) {
    if (evalue == null) {
        return true;
    }

    var elValue = evalue.toString();
    if (elValue.length == 0) {
        return true;
    } else {
        //check if there are non space characters.
        if (elValue.match(/^\s+$/)) {
            return true;
        }
    }
    return false;
}

function trim(s) {
    s = s.replace(/(^\s*)|(\s*$)/gi, "");
    s = s.replace(/[ ]{2,}/gi, " ");
    s = s.replace(/\n /, "\n");
    return s;
}

function makeReadOnly() {


    var formFields = document.getElementsByTagName("input");

    for (var i = 0; i < formFields.length; i++) {
        var formField = formFields[i];
        var elem = $("#" + formField.id);
        if (elem.hasClass("IASTextBox") || elem.hasClass("IASTextBoxMandatory") || elem.hasClass("IASTextBoxMandatoryWide") || elem.hasClass("IASEmailTextBox") || elem.hasClass("IASCheckBox") || elem.hasClass("IASDateTextBox") || elem.hasClass("IASTextBoxMandatoryWide") || elem.hasClass("IASTextBoxWide")) {
            formField.setAttribute("readonly", true);
            formField.style.backgroundColor = "#EEE";
        }
    }

    formFields = document.getElementsByTagName("select");

    for (i = 0; i < formFields.length; i++) {
        formField = formFields[i];
        if (formField.className == "IASComboBox" || formField.className == "IASComboBoxWide" || formField.className == "IASComboBoxMediumMandatory" || formField.className == "IASComboBoxSmallMandatory" || formField.className == "IASComboBoxMandatory") {
            formField.disabled = true;
            formField.style.backgroundColor = "#EEE";
        }
    }

    formFields = document.getElementsByTagName("textarea");

    for (i = 0; i < formFields.length; i++) {
        formField = formFields[i];
        if (formField.className == "IASTextArea" || formField.className == "IASTextAreaMandatory") {
            formField.setAttribute("readonly", true);
            formField.style.backgroundColor = "#EEE";
        }
    }
}

function setActionValue(value) {
    var Divs = document.getElementsByTagName('div');
    var mainDiv;
    for (var i = 0; i < Divs.length; i++) {
        if (Divs[i].className == 'MainDiv') {
            mainDiv = Divs[i];
            break;
        }
    }
    var hiddenInput = document.getElementById('action');
    if (hiddenInput == null) {
        hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('type', 'hidden');
        hiddenInput.setAttribute('id', 'action');
        hiddenInput.setAttribute('name', 'action');
        hiddenInput.setAttribute('value', value);
        mainDiv.appendChild(hiddenInput);
    } else {
        document.getElementById('action').value = value;
    }
}

/*function alert(msg,title,callback){
    if(title == null){
        title = 'Journal Distribution System';
    }
    jAlert(msg,title,callback);
    return false;
}*/

function jdsConfirm(msg, title, callback) {
    if (title.length == 0) {
        title = 'Journal Distribution System';
    }
    jConfirm(msg, title, callback);
    return false;
}


function jQueryCalendar(divId, disablefuturedates) {

    var _maxdate = null;
    if (disablefuturedates == true) {
        _maxdate = 0;
    }
    var div = "#" + divId;
    $(function() {
        $(div).datepicker({
            dateFormat: 'dd/mm/yy',
            maxDate: _maxdate,
            changeMonth: true,
            changeYear: true
        });
    });
}

function jQueryDatePicker(fromDiv, toDiv) {

    fromDiv = "#" + fromDiv;
    toDiv = "#" + toDiv;
    dateRangediv = fromDiv + "," + toDiv;


    $(function() {
        var dates = $(dateRangediv).datepicker({
            defaultDate: "-1m",
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd/mm/yy',
            showOtherMonths: true,
            selectOtherMonths: true,
            numberOfMonths: 2,
            showMonthAfterYear: true,
            showButtonPanel: true,
            onSelect: function(selectedDate) {
                //var option = this.id == "from" ? "minDate" : "maxDate",
                instance = $(this).data("datepicker"), date = $.datepicker.parseDate(
                instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
                //dates.not( this ).datepicker( "option", option, date );
            }
        });
        // set the default populated to today
        //$(fromDiv).datepicker("setDate",new Date());
        //$(toDiv).datepicker("setDate",new Date());
    });

}
/*
 * This function makes an ajax call to get data from server.
 * requesturl = request url
 * xmlrowTag = the tag name in the xml output that has the data value
 * formelementid= id of the element where the autocomplete should be displayed.
 */
function jdsAutoComplete(requestURL, xmlRowTag, formElementId) {

    var _formElementId = "#" + formElementId;
    var myArr = new Array;
    $(_formElementId).autocomplete({
        source: function(request, response) {
            $.ajax({
                type: "GET",
                url: requestURL,
                // change to full path of file on server
                data: {
                    "term": request.term
                },
                dataType: "xml",
                success: function(xml) {
                    myArr = [];
                    $(xml).find(xmlRowTag).each(function() {
                        myArr.push($(this).text());
                    });
                    response(myArr);
                }
            });
        },
        minLength: 3

    });

    //    // bind the autocompletechange event to the element, so we allow only values from the list
    //    $(_formElementId).bind('autocompletechange', function(){
    //
    //        if ($.inArray($(this).val(), myArr) == -1 &&  $(this).val().length > 0){
    //            $(this).val('');
    //            $(this).focus();
    //            alert('Please select a valid value from the list');
    //        }
    //
    //    });
    //    $.ajax({
    //        type: "GET",
    //        url: requestURL, // change to full path of file on server
    //        dataType: "xml",
    //        success: function(xml){
    //            $(xml).find(xmlRowTag).each(function(){
    //                myArr.push($(this).text());
    //            });
    //        },
    //        complete: function(){
    //            $(_formElementId).autocomplete({
    //                source: myArr,
    //                minLength: 1
    //            });
    //        },
    //        error: function() {
    //            alert("XML File could not be found");
    //        }
    //    });
}

/*
 * This function makes an ajax call to get data from server.
 * requesturl = request url
 * xmlrowTag = the tag name in the xml output that has the data value
 * formelementid= id of the element where the autocomplete should be displayed.
 * This function will append the valus to the already existing ones. Mainly helpful
 * to populate drop down lists.
 */
function jdsAppend(requestURL, xmlRowTag, formElementId, defaultSelect, callback) {


    var _formElementId = "#" + formElementId;
    var myArr = new Array;
    $.ajax({
        type: "GET",
        url: requestURL,
        // change to full path of file on server
        dataType: "xml",
        success: function(xml) {
            $(xml).find(xmlRowTag).each(function() {
                myArr.push($(this).text());
            });
        },
        complete: function() {
            var html = null;
            for (var i = 0; i < myArr.length; i++) {
                //set this variable to save the state from the last postback
                if ($(_formElementId).val() == myArr[i]) {
                    continue;
                }
                if (html == null) {
                    html = "<option value=" + "\"" + myArr[i] + "\"" + ">" + myArr[i] + "</option>";
                } else {
                    html += "<option value=" + "\"" + myArr[i] + "\"" + ">" + myArr[i] + "</option>";
                }

            }
            $(_formElementId).append(html);
            if (defaultSelect != undefined && defaultSelect.length > 0) {
                $(_formElementId).val(defaultSelect);
            }
            if (callback != undefined) {
                callback();
            };
        },
        error: function() {
            alert("XML File could not be found at " + requestURL);
        }
    });

}
// clears the JQGrid data
function resetGrid(gridID) {

    //var id = "#" + gridID
    // get IDs of all the rows odf jqGrid
    var rowIds = $(gridID).jqGrid('getDataIDs');
    // iterate through the rows and delete each of them
    for (var i = 0, len = rowIds.length; i < len; i++) {
        var currRow = rowIds[i];
        $(gridID).jqGrid('delRowData', currRow);
    }
    jQuery(gridID).clearGridData();
}

function PrintContent(divID) {
    var DocumentContainer = document.getElementById(divID);
    var WindowObject = window.open('', 'PrintWindow', 'width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');
    WindowObject.document.writeln(DocumentContainer.innerHTML);
    WindowObject.document.close();
    WindowObject.focus();
    WindowObject.print();
    WindowObject.close();
}

function GetCookieValue(cookieName, keyName) {

    var json = JSON.parse($.cookie(cookieName));
    if (json == null) {
        return null;
    }
    var _value = null;
    $.each(json, function(key, value) {
        if (key == keyName) {
            _value = value;
            return;
        }
    });
    return _value;
}

function jdsPost(form_id, url) {
    form_id = "#" + form_id;
    //$(form_id).attr("action", url);
    $(form_id).get(0).setAttribute('action', url);
    alert($(form_id).attr("action"));
    $(form_id).submit();
}

function monthNameToNumber(cellvalue, options, cell) {
    var _JDSConstants = new JDSConstants();
    var monthIndex = $.inArray(cellvalue, _JDSConstants.monthNames);
    return (monthIndex + 1);
}

function monthNumberToName(cellvalue, options, rowObj) {
    var _JDSConstants = new JDSConstants();
    return (_JDSConstants.monthNames[cellvalue - 1]);
}

function jdsEmail(url) {
    $.ajax({
        type: "GET",
        url: url,
        // change to full path of file on server
        dataType: "xml",
        success: function(xmlResponse) {
            $(xmlResponse).find("results").each(function() {
                var isSucess = $(this).find("success").text();
                if (parseInt(isSucess) === 1) {
                    alert("Email sent successfully");
                } else {
                    alert("Failed to send Email");
                }
            });
        },
        complete: function() {

        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert("Failed to send Email. " + textStatus + ": " + errorThrown);
        }
    });
}

function jdsPrint(url, windowName) {
    _window = window.open(url, windowName);
    _window.onload = function() {
        _window.document.title = windowName + " Print Preview";
    };
    return false;
}

function TestFileType(fileName, fileTypes) {
    if (!fileName) return false;

    dots = fileName.split(".");
    //get the part AFTER the LAST period.
    fileType = "." + dots[dots.length - 1];

    if (fileTypes.join(".").indexOf(fileType) === -1) {
        alert("Please only upload files that end in types: \n\n" + (fileTypes.join(" .")) + "\n\nPlease select a new file and try again.");
        return false;
    }
    return true;

}

function IsNumeric(sText) {
    var ValidChars = "0123456789.";
    var IsNumber = true;
    var Char;
    for (i = 0; i < sText.length && IsNumber === true; i++) {
        Char = sText.charAt(i);
        if (ValidChars.indexOf(Char) === -1) {
            IsNumber = false;
        }
    }
    return IsNumber;
}

function validateForTextOnly(FieldId) {
    var filter = /^[a-z]+$/;
    var str = document.getElementById(FieldId).value;
    var str1 = str.toLocaleString().toLowerCase();

    if (str1.length === 0) {
        alert("Please input text");
        document.getElementById(FieldId).focus();
    } else {
        if (!filter.test(str1)) {
            alert("Please input text only, no numbers or special characters!");
            document.getElementById(FieldId).value = "";
            document.getElementById(FieldId).focus();
        }
    }
}

function setEnterKeyAction(func) {
    $(document).keydown(function(event) {
        if (event.which === 13) {
            func();
        }
    });
}

function isNumber(FieldId) {
    if (!($.isNumeric(document.getElementById(FieldId).value))) {
        document.getElementById(FieldId).value = "";
        alert("Enter number");
    }
}

function YesNo2Boolean(value){
    if(value.toLowerCase() === 'yes'){
        return true;
    }
    return false;
}