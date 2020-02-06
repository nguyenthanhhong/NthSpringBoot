/** ---------------- datetime symbols ----------------
 d		: Day of the month as digits; no leading zero for single-digit days.
 dd		: Day of the month as digits; leading zero for single-digit days.
 ddd		: Day of the week as a three-letter abbreviation.
 dddd	: Day of the week as its full name.
 m		: Month as digits; no leading zero for single-digit months.
 mm		: Month as digits; leading zero for single-digit months.
 mmm		: Month as a three-letter abbreviation.
 mmmm	: Month as its full name.
 yy		: Year as last two digits; leading zero for years less than 10.
 yyyy	: Year as 4 digits.
 h		: Hours; no leading zero for single-digit hours (12-hour clock).
 hh		: Hours; leading zero for single-digit hours (12-hour clock).
 -H		: Hours; no leading zero for single-digit hours (24-hour clock).
 HH		: Hours; leading zero for single-digit hours (24-hour clock).
 M		: Minutes; no leading zero for single-digit minutes. Uppercase M unlike CF timeFormat's m to avoid conflict with months.
 MM		: Minutes; leading zero for single-digit minutes. Uppercase MM unlike CF timeFormat's mm to avoid conflict with months.
 s		: Seconds; no leading zero for single-digit seconds.
 ss		: Seconds; leading zero for single-digit seconds.
 l		: Milliseconds. 3 digits.
 L		: Milliseconds. 2 digits.
 t		: Lowercase, single-character time marker string: a or p.
 tt		: Two-character time marker string: am or pm.
 T		: Single-character time marker string: A or P.
 TT		: Two-character time marker string: AM or PM.
 Z		: US timezone abbreviation, e.g. EST or MDT. With non-US timezones or in the Opera browser, the GMT/UTC offset is returned, e.g. GMT-0500
 o		: GMT/UTC timezone offset, e.g. -0500 or +0230.
 ---------------- end datetime symbols ----------------**/

const dateTimeType = ["date", "day", "month"];
function fn_setLocaleMask() {
    /** process for multi select box **/
    $('select').each(function() {
        if($(this).attr("multiple") == "multiple") {
            $(this).multiselect({
                enableClickableOptGroups: true,
                enableCollapsibleOptGroups: true,
                enableFiltering: true,
                includeSelectAllOption: true
            });
        }
    });

    /** process for text input **/
    $(":input").each(function() {
        var $inputObj = $(this);
        let attrName = $(this).attr("txtformat");
        switch(attrName) {
            case "date":
                fn_makeDatePicker($inputObj, LOCAL.L_DATE_FORMAT, 0);
                break;
            case "day":
                fn_makeDatePicker($inputObj, LOCAL.L_DAY_FORMAT, 0);
                break;
            case "month":
                fn_makeDatePicker($inputObj, LOCAL.L_MONTH_FORMAT, 1);
                break;
            case "year":
                fn_makeDatePicker($inputObj, "yyyy", 2);
                break;
            case "time":
                fn_makeTimeFormat($inputObj, LOCAL.L_TIME_FORMAT);
                break;
            case "hh:MM TT":
                fn_makeTimeFormat($inputObj, "hh:MM TT");
                break;
            case "HH:MM:ss":
                fn_makeTimeFormat($inputObj, "HH:MM:ss");
                break;
            case "number":
                fn_makeDecimalFormat($inputObj, LOCAL.L_NUM_GROUP_SEPARATOR, LOCAL.L_NUM_RADIX_POINT, LOCAL.L_NUM_DIGITS);
                break;
            case "onlynumber":
                fn_makeDecimalFormat($inputObj,"", "", 0);
                break;
            case "#,###":
                fn_makeDecimalFormat($inputObj,",", "", 0);
                break;
            case "#,###.#0":
                fn_makeDecimalFormat($inputObj,",", ".", 2);
                break;
            case "#,###.##0":
                fn_makeDecimalFormat($inputObj,",", ".", 3);
                break;
            case "#,###.###0":
                fn_makeDecimalFormat($inputObj,",", ".", 4);
                break;
            case "####.#0":
                fn_makeDecimalFormat($inputObj,"", ".", 2);
                break;
            case "currency":
                fn_makeCurrencyFormat($inputObj);
                break;
            case "email":
                Inputmask("email").mask(this);
                break;
            case "url":
                Inputmask("url").mask(this);
                break;
            case "percent":
                $inputObj.inputmask('percentage', {
                    showMaskOnHover: true,
                    showMaskOnFocus: true,
                    digits: 2
                });
                break;
            default:
                $inputObj.inputmask(attrName);
        }
    });
}

function fn_makeDatePicker(element, txtFormat, viewMode) {
    element.attr("maxlength", txtFormat.length);
    element.datepicker({
        format: txtFormat,
        language: PAGE_INFO.LANG_CD,
        minViewMode: viewMode,
        autoclose: true,
        todayHighlight: true,
        daysOfWeekHighlighted: "0,6"
    })
    .inputmask('datetime', {
        inputFormat: txtFormat,
        showMaskOnHover: true,
        showMaskOnFocus: true,
        autoUnmask : true,
        clearIncomplete: true,
        onUnMask: function(maskedValue, unmaskedValue) {
            if (maskedValue && maskedValue != txtFormat) {
                return fn_getyyyymmdd(maskedValue, txtFormat);
            }
            return unmaskedValue;
        }
    });

    if( $(this).hasClass('calendar') === false ) {
        $(this).addClass('calendar');
    }
    if ($(this).attr("readonly") != undefined && $(this).attr("readonly") != "false") {
        $(this).addClass('readonlyCalendarBg ');
    }
}

function fn_makeTimeFormat(element, txtFormat) {
    element.attr("maxlength", txtFormat.length + 1);
    element.inputmask('datetime', {
        inputFormat: txtFormat,
        showMaskOnHover: true,
        showMaskOnFocus: true
    });
}

function fn_makeDecimalFormat(element, char_Group_Separator, char_Radix_Point, number_digits) {
    element.inputmask({
        alias: 'decimal',
        groupSeparator: char_Group_Separator,
        radixPoint : char_Radix_Point,
        autoGroup: true,
        digits: number_digits,
        digitsOptional: false,
        placeholder: '0',
        autoUnmask: true ,
        unmaskAsNumber: true,
    });
}

function fn_makeCurrencyFormat(element) {
    element.inputmask({
        alias: 'currency',
        groupSeparator: LOCAL.L_NUM_GROUP_SEPARATOR,
        radixPoint : LOCAL.L_NUM_RADIX_POINT,
        autoGroup: true,
        digits: LOCAL.L_CURR_DIGITS,
        prefix: LOCAL.L_CURR_PREFIX,
        suffix: LOCAL.L_CURR_SUFFIX,
        digitsOptional: false,
        placeholder: '0',
        autoUnmask: true ,
        unmaskAsNumber: true,
    });
}

// if input is datepicker - trigger change when val(new_val) is called (even if the value didn't actually changed)
/**
 * set value (date time) to text input
 * - the data in system have format yyyymmdd
 * - the display data have custom format
 * - this function convert system data to display data (in date picker component)
 */
(function ($) {
    let originalVal = $.fn.val;
    $.fn.val = function(value) {
        if (typeof value != 'undefined') {
            let txtformat = $(this).attr("txtformat");
            if($(this).is('input:text') && dateTimeType.indexOf(txtformat) != -1){
                if (value) {
                    var preVal = value;
                    if (!fn_isIncludeSpecChar(preVal)) {
                        value = fn_setTxtFormat(txtformat, value);
                        $(this).datepicker( "setDate" , value);
                    }
                }
            }
            // setter invoked, do processing
            return originalVal.call(this, value);
        }
        //getter invoked do processing
        return originalVal.call(this);
    };
})(jQuery);

/**
 * convert system datetime data to datetime data with custom format
 * @param type: date, day, month
 * @param value
 * @returns {string}
 */
function fn_setTxtFormat(type, value) {
    if (!(type) || !(value)) {
        return "";
    }
    if (dateTimeType.indexOf(type) != -1) {
        let date_format = "yy";
        const sysDateFm = LOCAL.L_DB_DATE_FORMAT.toUpperCase();
        if (type == "date") {
            date_format = LOCAL.L_DATE_FORMAT.indexOf("yyyy") > -1 ? LOCAL.L_DATE_FORMAT.replace(/yyyy/g, 'yy') : LOCAL.L_DATE_FORMAT;
        } else if (type == "day") {
            date_format = LOCAL.L_DAY_FORMAT.indexOf("yyyy") > -1 ? LOCAL.L_DAY_FORMAT.replace(/yyyy/g, 'yy') : LOCAL.L_DAY_FORMAT;
        } else if (type == "month"	) {
            date_format = LOCAL.L_MONTH_FORMAT.indexOf("yyyy") > -1 ? LOCAL.L_MONTH_FORMAT.replace(/yyyy/g, 'yy') : LOCAL.L_MONTH_FORMAT;
        }
        //value = $.datepicker.formatDate(date_format, new Date(moment(value, sysDateFm)));
        value = new Date(moment(value, sysDateFm));
    }
    return value;
}

/**
 * make datetime value in input text to format "YYYYMMDD"
 * @param strValue
 * @param format
 * @returns {string}
 */
function fn_getyyyymmdd(strValue, format) {
    if(!strValue) return "";
    strValue = strValue.trim();
    format = format.trim().toUpperCase();

    const yymmdd = new Date(moment(strValue, format));
    let strDate = fn_convertDateToDbFormat(yymmdd, format);

    return strDate;
}

function fn_convertDateToDbFormat(dayValue, format) {
    if(!(dayValue instanceof Date)) {
        return dayValue;
    }
    if(!format) {
        format = LOCAL.L_DB_DATE_FORMAT;
    }
    format = fn_removeSpecChar(format.trim().toLowerCase());
    let year = format.indexOf("yyyy") > -1 ? String(dayValue.getFullYear()) : "";
    let month = format.indexOf("mm") > -1 ? String(dayValue.getMonth() + 1).lpad(2, '0') : "";
    let day = format.indexOf("dd") > -1 ? String(dayValue.getDate()).lpad(2, '0') : "";

    return LOCAL.L_DB_DATE_FORMAT.replace("yyyy", year).replace("mm", month).replace("dd", day);
}