$.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();
    var inputValue = "";

    $.each(a, function() {
        inputValue = this.value;
        // ---------- Date Input Data - start ----------
        if ($('#' + this.name).hasClass('calendar') == true) {
            inputValue = fn_removeSpecChar(inputValue);

        } else if ($('#' + this.name).hasClass('number') == true && $('#' + this.name).attr("mask")) {
            inputValue = inputValue.replace(/,/g, '');
        }
        // ---------- Date Input Data - end ----------
        if (o[this.name] !== undefined) {
            o[this.name] = o[this.name] + "," + inputValue;

        } else {
            o[this.name] = inputValue || '';
        }
    });
    return o;
};
$.fn.populateToForm = function(resultData, datasetName, changeEventTrigger) {
    var $frm = this, frm = $frm.get(0), data;

    if (frm === undefined || frm.tagName.toUpperCase() !== 'FORM') {
        alert('populateToForm() - form element use only');
        return;
    }

    if (datasetName == null) {
        data = resultData;

    } else {
        if (!resultData[datasetName]) {
            alert('There is no dataset named ' + datasetName);
            return;
        }
        data = resultData[datasetName];

        if (data == undefined) {
            return;
        }
    }
    frm.reset();
    populateProcess(data, $frm, changeEventTrigger);
};

/**
 * populateToForm
 */
populateProcess = function(data, $frm, changeEventTrigger) {
    var dataValue;
    for (let dataKey in data) {
        dataValue = data[dataKey];

        $frm.find(':input').each(function(idx) {
            var input = this, $input = $(input), inputName = input.name, initValue = input.value;

            if (input.name != "undefined" && dataKey === inputName) {
                var type = input.type.toLowerCase();

                if (type === 'radio') {

                    if (dataValue === initValue) {
                        $input.prop('checked', true);
                    }

                } else if (type == 'checkbox') {
                    if (!dataValue) {
                        dataValue = '0';
                    } else if (dataValue == true) {
                        dataValue = '1';
                    }
                    $input.val(dataValue);

                    if (dataValue == '0') {
                        $input.prop('checked', false);
                    } else if (dataValue == '1') {
                        $input.prop('checked', true);
                    }

                } else {
                    $input.val(dataValue);
                }
                if (changeEventTrigger) {
                    $input.trigger('changeval');
                }
            }
        });
    }
};

/**
 * Form Validation
 */
$.fn.checkFormValidation = function() {
    var $frm = this;
    var rsltChk = true;

    $frm.find(':input:not(:disabled)').each(function() {
        var $input = $(this);

        if ($input.hasClass('none'))
            return;

        var typ = $input.get(0).type;
        if ((typ != "checkbox" && typ != "radio") && !$input.is(':visible'))
            return;

        if ($input.attr("required") != undefined) {
            if (checkRequired($input) == false) {
                rsltChk = false;
                return rsltChk;
            }
        }

        if ($input.attr("maxbyte") != undefined) {
            if (checkMaxbyte($input, $input.attr("maxbyte")) == false) {
                rsltChk = false;
                return rsltChk;
            }
        }

        if ($input.attr("number") != undefined) {
            if (checkNumber($input) == false) {
                rsltChk = false;
                return rsltChk;
            }
        }

        if ($(this).attr("email") != undefined) {
            if (checkEmail($input) == false) {
                rsltChk = false;
                return rsltChk;
            }
        }
    });
    return rsltChk;
};

/**
 * reset from
 */
$.fn.resetForm = function(initData) {
    var $frm = this;
    $frm.find(':input').each(
        function() {
            var $elem = $(this), id = this.id, name = this.name, userVal, type = (nvl(this.type, "")).toLowerCase();

            if (type === 'radio') {
                $elem.prop('checked', false);
                return true;
            }

            if (initData) {
                if (initData[id]) {
                    userVal = initData[id];

                } else if (initData[name]) {
                    userVal = initData[name];
                }
                if (userVal) {
                    if (userVal.toLowerCase() === 'null') {
                        userVal = '';
                    }
                    $elem.val(userVal);
                    return true; // loop continue
                }
            }

            if ($elem.hasClass('calendar')) {
                const today = new Date();
                let todayStr = fn_convertDateToDbFormat(today);
                $elem.val(todayStr);
                return true;
            }

            if (type === 'checkbox') {
                $elem.prop('checked', false);
            } else {
                $elem.val('');
            }

        }
    );
};

function checkRequired(obj) {
    $objInput = $(obj);
    let message = $objInput.attr("title");
    if (message === undefined) {
        message = $objInput.attr("placeholder");
    }
    if ($objInput.hasClass("number")) {
        if ($objInput.val() == "" || parseFloat($objInput.val().trim()) == 0) {
            fn_showMessage("Please input {0}", message);
            $objInput.focus();
            return false;
        } else {
            return true;
        }
    } else {
        if (
            $objInput.get(0).type == "checkbox" ||
            $objInput.get(0).type == "radio"
        ) {
            var objName = $objInput.get(0).name;
            if ($("input[name='" + objName + "']:checked").length == 0) {
                fn_showMessage("Please input {0}", message);
                $objInput.focus();
                return false;
            } else {
                return true;
            }
        } else if ($objInput.hasClass("calendarM")) {
            if ($objInput.val() == "") {
                fn_showMessage("Please input {0}", message);
                return false;
            } else {
                return true;
            }
        } else {
            if ($.trim($objInput.val()) == "") {
                fn_showMessage("Please input {0}", message);
                $objInput.focus();
                return false;
            } else {
                return true;
            }
        }
    }
}
function checkMaxbyte(obj, maxByte) {
    var $objInput = $(obj);
    var val = $objInput.val();
    if ($objInput.hasClass("number") && $objInput.attr("mask")) {
        val = val.replace(/,/g, "");
    }
    if (val.getByte() > maxByte) {
        fn_showMessage("Please input value in less than {0} byte.", maxByte);
        $objInput.select();
        $objInput.focus();
        return false;
    } else {
        return true;
    }
}