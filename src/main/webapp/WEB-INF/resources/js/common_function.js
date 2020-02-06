var g_formatLang = "en";
var today = new Date();
var g_today = $.datepicker.formatDate('yymmdd', today);

var g_localeOptions = {
        langCd : "vi",                                                      // CONST.LOCALE_LANG_CD,
        currCd : "VND",                                                     // CONST.LOCALE_CURR_CD,
        currNm : "VND",                                                     // CONST.LOCALE_CURR_NM,
        currencyUnit : "₫",                                                 // CONST.LOCALE_CURRENCY_UNIT,
        currency_Group_Separator: ",",                                      // CONST.LOCALE_CURRENCY_GROUP_SEPARATOR,
        currency_Radix_Point : "",                                          // CONST.LOCALE_CURRENCY_RADIX_POINT,
        currency_Digit_Count : "0",                                         // CONST.LOCALE_CURRENCY_DIGIT_COUNT,
        fmCurrPlaceCd : "01",                                               // CONST.LOCALE_FM_CURR_PLACE_CD,
        dateFormat_nm : "dd/mm/yyyy",                                       // CONST.LOCALE_DATE_FORMAT_NM,
        yymmFormat : "mm/yyyy",                                             // CONST.LOCALE_YYMM_FORMAT,
        mmddFormat : "dd/mm",                                               // CONST.LOCALE_MMDD_FORMAT,
        timeFormat : "hh:mm:ss",
        number_Group_Separator : ",",                                       // CONST.LOCALE_NUMBER_GROUP_SEPARATOR,
        number_Radix_Point : ".",                                           // CONST.LOCALE_NUMBER_RADIX_POINT,
        number_Digit_Count : "2",                                           // CONST.LOCALE_NUMBER_DIGIT_COUNT,
        numberType : "#,##0",                                               // CONST.LOCALE_NUMBER_TYPE,
        imgPath : "../images/icon_calendar.png"
};

if(typeof CONST !== "undefined"){
    g_formatLang = CONST.LOCALE_FORMAT_LANG;
    g_localeOptions = {
            langCd : CONST.LOCALE_LANG_CD,
            currCd : CONST.LOCALE_CURR_CD,
            currNm : CONST.LOCALE_CURR_NM,
            currencyUnit : CONST.LOCALE_CURRENCY_UNIT,
            currency_Group_Separator: CONST.LOCALE_CURRENCY_GROUP_SEPARATOR,
            currency_Radix_Point : CONST.LOCALE_CURRENCY_RADIX_POINT,
            currency_Digit_Count : CONST.LOCALE_CURRENCY_DIGIT_COUNT,
            fmCurrPlaceCd : CONST.LOCALE_FM_CURR_PLACE_CD,
            dateFormat_nm : CONST.LOCALE_DATE_FORMAT_NM,
            yymmFormat : CONST.LOCALE_YYMM_FORMAT,
            mmddFormat : CONST.LOCALE_MMDD_FORMAT,
            timeFormat : CONST.SYSOPT_TIME_FORMAT_NM,
            number_Group_Separator : CONST.LOCALE_NUMBER_GROUP_SEPARATOR,
            number_Radix_Point : CONST.LOCALE_NUMBER_RADIX_POINT,
            number_Digit_Count : CONST.LOCALE_NUMBER_DIGIT_COUNT,
            numberType : CONST.LOCALE_NUMBER_TYPE,
            imgPath : "../images/icon_calendar.png"
    };
}

// Locale applied function in business screen for locale processing in business screen
// Manage dates, numbers, amounts, calendars, and more.
function setLocaleMask(lo) {

	if (fn_isNull(lo)) {
		lo = g_localeOptions;
	}
	var seperators = fn_removeChar(lo.numberType, /[#0]/g).split('');
	var numGrpSep = lo.numberType.substr(lo.numberType.indexOf(seperators[0]), 1);

	$(":input").each(function() {

		var $inputObj = $(this);
		/***************************************** date time start *************************************************/
		if ($(this).attr("txtformat") == "month") {

			var showOn = "button" ;

			var date_format = lo.yymmFormat.indexOf("yyyy") > -1 ? lo.yymmFormat.replace(/yyyy/g, 'yy') : lo.yymmFormat;
			$(this).attr("maxlength", "7");
			var $dateObj = $(this);
			var locale = moment().locale(g_formatLang);

			var inMask = lo.yymmFormat.replace(/yy/g, '99');
			inMask = inMask.replace(/mm/g, '99').replace(/dd/g, '99');

			$(this).datepicker({
				  dateFormat: lo.yymmFormat,
				  format: lo.yymmFormat,
				  language: g_formatLang,
				  minViewMode: 1,
				  changeYear: true,
				  autoclose: true,
				  buttonImage: g_localeOptions.imgPath,
				  buttonImageOnly: false,
				  yearRange: 'c-120:c+120',
				  monthNames:locale._locale._months,
				  monthNamesShort:locale._locale._months,
				  dayNames:locale._locale._weekdays,
				  dayNamesMin:locale._locale._weekdaysMin,
				  dayNamesShort:locale._locale._weekdaysShort
		    })
		    .inputmask(inMask, {
		    	"placeholder": lo.yymmFormat,
				"autoUnmask" : true,
				"clearIncomplete": true,
				onUnMask: function(maskedValue, unmaskedValue) {
					if (!fn_isNull(maskedValue) && maskedValue != lo.yymmFormat) {
						var retVal = fn_getyymmddDate(maskedValue, lo.yymmFormat);
						return retVal.substr(0, retVal.length-2);
					}
					return unmaskedValue;
			    }
		    })
		    .on("keyup", function(e) {
				if (isFinite(e.key)) {
					var dateVal = $(this).val();
					if (!isEmpty(dateVal) && dateVal.length == 6) {
						$(this).data("datepicker").dates.replace(Date.strToDate2(dateVal, "YYYYMM")) ;
						$(this).data("datepicker").viewDate = $(this).data("datepicker").dates.get(-1) ;
						$(this).data("datepicker").fill();
					}
				}
			}) ;

			if( $(this).hasClass('calendar') == false ) {
				$(this).addClass('calendar');
			}
			if ($(this).attr("readonly") != undefined && $(this).attr("readonly") != "false") {
				$(this).addClass('readonlyCalendarBg ');
			}
		}

		if ($(this).attr("txtformat") == "monthday") {

			var locale = moment().locale(g_formatLang);

			var inMask = lo.mmddFormat.replace(/yy/g, '99');
			inMask = inMask.replace(/mm/g, '99').replace(/dd/g, '99');

			$inputObj.attr("maxlength", "5");

			var maxMonth = '+' + (12-g_toNum(_dateFormatString("%m"))) + 'm'
			$(this).datepicker({
				  dateFormat: lo.mmddFormat,
				  format: lo.mmddFormat,
				  language: g_formatLang,
				  changeYear: false,
				  autoclose: true,
				  buttonImage: g_localeOptions.imgPath,
				  buttonImageOnly: false,
				  minDate: new Date(g_toNum(_dateFormatString("%Y")), 1 - 1, 1),
				  maxDate: maxMonth,
				  yearRange: 'c:c',
				  monthNames:locale._locale._months,
				  monthNamesShort:locale._locale._months,
				  dayNames:locale._locale._weekdays,
				  dayNamesMin:locale._locale._weekdaysMin,
				  dayNamesShort:locale._locale._weekdaysShort
		    }).on('show', function() {
		    	// remove the year from the date title before the datepicker show
		        var dateText  = $(".datepicker-days .datepicker-switch").text();
		        var dateTitle = dateText.replace(/\b([0-9]{4})\b(년?)/g, '').trim();
		        $(".datepicker-days .datepicker-switch").text(dateTitle);
		    }).inputmask(inMask, {
		    	"placeholder": lo.mmddFormat,
				"autoUnmask" : true,
				"clearIncomplete": true,
				onUnMask: function(maskedValue, unmaskedValue) {
					if (!fn_isNull(maskedValue) && maskedValue != lo.mmddFormat) {
						var retVal = fn_getyymmddDate(maskedValue, lo.mmddFormat);
						return retVal.substr(4, retVal.length-4);
					}
					return unmaskedValue;
			    }
		    })
		   .on("keyup", function(e) {
				if (isFinite(e.key)) {
					var dateVal = $(this).val();
					if (!isEmpty(dateVal) && dateVal.length == 4) {
						var curDate = g_today.substring(0,4)+dateVal;
						$(this).data("datepicker").dates.replace(Date.strToDate(curDate, "YYYYMMDD")) ;
						$(this).data("datepicker").viewDate = $(this).data("datepicker").dates.get(-1) ;
						$(this).data("datepicker").fill();
					}
				}
			}) ;

			if( $(this).hasClass('calendar') == false ) {
				$(this).addClass('calendar');
			}
			if ($(this).attr("readonly") != undefined && $(this).attr("readonly") != "false") {
				$(this).addClass('readonlyCalendarBg ');
			}
		}

		if ($(this).attr("txtformat") == "date") {

			var datePickerFormat  = lo.dateFormat_nm.indexOf("yyyy") > -1 ? lo.dateFormat_nm.replace(/yyyy/g, 'yy') : lo.dateFormat_nm;
			$inputObj.attr("maxlength", "10");
			var locale = moment().locale(g_formatLang);

			$(this).datepicker({
				  dateFormat: datePickerFormat,
				  format: lo.dateFormat_nm,
				  language: g_formatLang,
				  autoclose: true,
				  changeYear: true,
				  todayHighlight: true,
				  changeMonth: true,
				  showMonthAfterYear: true,
				  buttonImage: g_localeOptions.imgPath,
				  buttonImageOnly: false
				  ,minDate: new Date(1901, 1 - 1, 1)
				  ,yearRange: 'c-40:c+10',
				  monthNames:locale._locale._months,
				  monthNamesShort:locale._locale._months,
				  dayNames:locale._locale._weekdays,
				  dayNamesMin:locale._locale._weekdaysMin,
				  dayNamesShort:locale._locale._weekdaysShort
			})
			.inputmask(lo.dateFormat_nm, {
				"placeholder" :lo.dateFormat_nm,
				"autoUnmask" : true,
				"clearIncomplete": true,
				onUnMask: function(maskedValue, unmaskedValue) {
					if (!fn_isNull(maskedValue) && maskedValue != lo.dateFormat_nm) {
						return fn_getyymmddDate(maskedValue, lo.dateFormat_nm);
					}
					return unmaskedValue;
			    }
			})
			.on("keyup", function(e) {
				if (isFinite(e.key)) {
					var value = $(this).val();
					if (!fn_isNull(value) && value.length == 8) {
						$(this).data("datepicker").dates.replace(Date.strToDate(value, "YYYYMMDD")) ;
						$(this).data("datepicker").viewDate = $(this).data("datepicker").dates.get(-1) ;
						$(this).data("datepicker").fill();
					}
				}
			});

			if( $(this).hasClass('calendar') == false ) {
				$(this).addClass('calendar');
			}
			if ($(this).attr("readonly") != undefined && $(this).attr("readonly") != "false") {
				$(this).addClass('readonlyCalendarBg ');
			}
		}

		if ($(this).attr("txtformat") == "time") {
			$inputObj.attr("maxlength", "8");
			var timeformat = lo.timeFormat.toLowerCase();
			timeformat =  timeformat.indexOf(" tt") > -1 ? timeformat.replace(/tt/g, 't') : timeformat;
			$(this).inputmask(timeformat,{
				"placeholder" : timeformat.replace(/t/g, 'a'),
				"autoUnmask" : true,
				"clearIncomplete": true,
				onUnMask: function(maskedValue, unmaskedValue) {
					if (!fn_isNull(maskedValue)) {
						return g_formatTime(maskedValue, g_toMomentFormat(null, g_localeOptions.timeFormat), 'HHmmss');
					}
					return unmaskedValue;
			    }
			});
		}

		if ($(this).attr("txtformat") == "hh:mm t") {
			$inputObj.attr("maxlength", "8");

			$(this).inputmask("hh:mm t",{
				"placeholder" : "hh:mm a",
				"autoUnmask" : true,
				"clearIncomplete": true,
				onUnMask: function(maskedValue, unmaskedValue) {
					if (!fn_isNull(maskedValue)) {
						return g_formatTime(maskedValue, g_toMomentFormat(null, "hh:mm a"), 'HHmmss');
					}
					return unmaskedValue;
			    }
			} );
		}

		if ($(this).attr("txtformat") == "hh:mm:ss") {
			$inputObj.attr("maxlength", "8");
			$(this).inputmask("hh:mm:ss",{
				"autoUnmask" : true,
				"clearIncomplete": true,
				onUnMask: function(maskedValue, unmaskedValue) {
					if (!fn_isNull(maskedValue)) {
						return g_formatTime(maskedValue, g_toMomentFormat(null, "hh:mm:ss"), 'HHmmss');
					}
					return unmaskedValue;
			    }
			});
		}

		if ($(this).attr("txtformat") == "hh:mm") {
			$inputObj.attr("maxlength", "5");
			$(this).inputmask("hh:mm",{
				"autoUnmask" : true,
				"clearIncomplete": true,
				onUnMask: function(maskedValue, unmaskedValue) {
					if (!fn_isNull(maskedValue)) {
						return g_formatTime(maskedValue, g_toMomentFormat(null, "hh:mm"), 'HHmmss');
					}
					return unmaskedValue;
			    }
			});
		}
		/***************************************** date time end *************************************************/

        /***************************************** number *****************************************/
        var nullAble = true;
        if ($(this).attr("txtformat") == "number" || $(this).attr("txtformat") == "onlynumber" || $(this).attr("txtformat") == "money"
            || $(this).attr("txtformat") == "currency" || $(this).attr("txtformat") == "normalmoney" || $(this).attr("txtformat") == "percent" ) {

            if ($(this).attr("nullable") != undefined && $(this).attr("nullable") == "false") {
                nullAble = false;
            }
        }

        if ($(this).attr("txtformat") == "number") {
            Inputmask.extendAliases({
                "number_format" : {
                    alias : 'numeric',
                    groupSeparator : lo.number_Group_Separator,
                    radixPoint : lo.number_Radix_Point,
                    autoGroup : true,
                    digits : lo.number_Digit_Count,
                    digitsOptional : true,
                    placeholder : nullAble ? '' : '0',
                    prefix: "",
                    suffix: "",
                    autoUnmask : true,
                    removeMaskOnSubmit : true,
                    clearMaskOnLostFocus: nullAble,
                    onUnMask : function(maskedValue, unmaskedValue, opts) {
                        if (unmaskedValue === "" && opts.nullable === true) {
                            return unmaskedValue;
                        }
                        var processValue = maskedValue.replace(opts.prefix, "");
                        processValue = processValue.replace(opts.suffix, "");
                        processValue = processValue.replace(new RegExp(Inputmask
                                .escapeRegex(opts.groupSeparator), "g"), "");
                        if (opts.radixPoint !== ""
                            && processValue.indexOf(opts.radixPoint) !== -1)
                            processValue = processValue.replace(Inputmask.escapeRegex
                                    .call(this, opts.radixPoint), ".");
                        return processValue;
                    }
                }
            });

            $(this).inputmask("number_format");
        }

        if ($(this).attr("txtformat") == "onlynumber") {
            Inputmask.extendAliases({
                "only_number_format" : {
                    alias : 'numeric',
                    groupSeparator : numGrpSep,		//lo.number_Group_Separator,
                    radixPoint : "",
                    autoGroup : true,
                    digits : 0,
                    digitsOptional : true,
                    placeholder : nullAble ? '' : '0',
                    prefix: "",
                    suffix: "",
                    autoUnmask : true,
                    removeMaskOnSubmit : true,
                    clearMaskOnLostFocus: nullAble,
                    onUnMask : function(maskedValue, unmaskedValue, opts) {
                        if (unmaskedValue === "" && opts.nullable === true) {
                            return unmaskedValue;
                        }
                        var processValue = maskedValue.replace(opts.prefix, "");
                        processValue = processValue.replace(opts.suffix, "");
                        processValue = processValue.replace(new RegExp(Inputmask.escapeRegex(opts.groupSeparator), "g"), "");
                        return processValue;
                    },
                    oncomplete: function(e) {
                        var currVal = $(e.currentTarget).inputmask('unmaskedvalue');
                        if (gfn_isNull(currVal)) {
                            $(this).val("0");
                        }
                    },
                    onincomplete: function() {
                        var currVal = $(this).inputmask('unmaskedvalue');
                        if (gfn_isNull(currVal)) {
                            $(this).val("0");
                        }
                    }
                }
            });

            $(this).inputmask("only_number_format");
        }

        /***************************************** currency *****************************************/
        var Prefix = "";
        var Suffix = "";

        var isDisplayUnit = false;
        var currUnit = "";
        if ($(this).attr("txtformat") == "money" || $(this).attr("txtformat") == "currency" || $(this).attr("txtformat") == "normalmoney" ) {
            if ($(this).attr("displayUnit") != undefined && $(this).attr("displayUnit") == "true") {
                isDisplayUnit = true;
            }

            currUnit = ( !gfn_isNull(lo.currencyUnit) && isDisplayUnit)  ? lo.currencyUnit : "";
            if (!gfn_isNull(currUnit)) {
                if (lo.fmCurrPlaceCd=="01"){
                    Prefix = currUnit + " ";
                    Suffix = "";
                }else {
                    Prefix = "";
                    Suffix = currUnit + " ";
                }
            }

            Inputmask.extendAliases({
                "currency_format" : {
                    alias : 'numeric',
                    groupSeparator : lo.currency_Group_Separator,
                    radixPoint : lo.currency_Radix_Point,
                    autoGroup : true,
                    digits : lo.currency_Digit_Count,
                    digitsOptional : true,
                    placeholder : nullAble ? '' : '0',
                    prefix: Prefix,
                    suffix: Suffix,
                    autoUnmask : true,
                    removeMaskOnSubmit : true,
                    clearMaskOnLostFocus: nullAble,
                    onUnMask : function(maskedValue, unmaskedValue, opts) {
                        if (unmaskedValue === "" && opts.nullable === true) {
                            return unmaskedValue;
                        }
                        var processValue = maskedValue.replace(opts.prefix, "");
                        processValue = processValue.replace(opts.suffix, "");
                        processValue = processValue.replace(new RegExp(Inputmask
                                .escapeRegex(opts.groupSeparator), "g"), "");
                        if (opts.radixPoint !== ""
                            && processValue.indexOf(opts.radixPoint) !== -1)
                            processValue = processValue.replace(Inputmask.escapeRegex
                                    .call(this, opts.radixPoint), ".");
                        return processValue;
                    },
                }
            });
        }

        if ($(this).attr("txtformat") == "money") {
            $(this).inputmask("currency_format");
        }

        if ($(this).attr("txtformat") == "currency") {
            $(this).inputmask("currency_format");
        }

        if ($(this).attr("txtformat") == "normalmoney") {
            $(this).inputmask({
                alias: "currency",
                "clearIncomplete": true,
                prefix: Prefix,
                suffix: Suffix,
                placeholder : nullAble ? '' : '0',
                clearMaskOnLostFocus: nullAble,
                autoUnmask : true
            });
        }

        /***************************************** others *****************************************/
        if ($(this).attr("txtformat") == "mailaddr") {
            Inputmask("email").mask(this);
        }

        if ($(this).attr("txtformat") == "url") {
            Inputmask("url").mask(this);
        }

        if ($(this).attr("txtformat") == "percent") {
            $(this).inputmask('percentage', {
                reverse: true,
                autoUnmask : true,
                removeMaskOnSubmit : true,
                clearMaskOnLostFocus: false,
                onUnMask: function(maskedValue, unmaskedValue) {
                    return $.trim(maskedValue.replace(/\%/g, ''));
                }
            });
        }
	});
}

function fn_removeChar(str, regExp) {
	return str.replace(regExp, "");
}

function fn_isNull(sValue) {
	if ( sValue instanceof String ) {
		var sVal = new String(sValue);
		if (sVal.valueOf() == "undefined" || sValue == null || sValue == "null" || sValue.trim().length <= 0 ) return true;
	} else {
		if(typeof(sValue) == "undefined" || sValue == "null" || sValue == "undefined" || sValue == null || sValue == undefined || sValue.length == 0 ) return true;
	}

    var v_ChkStr = new String(sValue);
    if (v_ChkStr == null||v_ChkStr.length == 0 ) return true;

    return false;
}

function fn_getyymmddDate(strCalText, format) {
	if(isEmpty(strCalText)) return "";
	strCalText = fn_removeChar(strCalText);
	format = fn_removeChar(format).toUpperCase();

	var yymmdd = new Date(moment(strCalText, format));
	var strDate = String(yymmdd.getFullYear()) + String(yymmdd.getMonth()+1).lpad(2, '0') + String(yymmdd.getDate()).lpad(2, '0');

	return strDate;
}

function fn_setInputLimit(obj, limitCd, maxlength) {

	var placeholderFormat = rpad("", maxlength, "9");

	switch (limitCd) {
		case '01': {
			obj.unmask();
			obj.removeAttr('placeholder');
			break;
		}
		case '02': {
			obj.attr('maxlength', maxlength);
			obj.bind('blur', function () {
				var maxlen = g_toNum(obj.attr('maxlength'));
				if (obj.val().length > 0 && maxlen != obj.val().length) {
					showModalMessage("MSG_CM_0061", g_toStr(maxlen));
					obj.val("");
					obj.focus();
				}
			});
			break;
		}
		case '03': {
			obj.attr('maxlength', maxlength);
			obj.inputmask('Regex', {regex: "^[0-9]+$"});
			obj.inputmask(placeholderFormat);
			obj.bind('blur', function () {
				var maxlen = g_toNum(obj.attr('maxlength'));
				if (obj.val().length > 0 && maxlen != obj.val().length) {
					showModalMessage("MSG_CM_0061", g_toStr(maxlen));
					obj.val("");
					obj.focus();
				}
			});
			break;
		}
		case '04': {
			obj.attr('maxlength', maxlength);
			break;
		}
		case '05': {
			obj.inputmask('Regex', {regex: "^[0-9]+$"});
			obj.attr('maxlength', maxlength);
			break;
		}
		case '06': {
			obj.attr('minlen', maxlength);
			obj.bind('blur', function () {
				var minlen = g_toNum(obj.attr('minlen'));
				if (obj.val().length > 0 && minlen > obj.val().length) {
					showModalMessage("MSG_CM_0033", g_toStr(minlen));
					obj.val("");
					obj.focus();
				}
			});
			break;
		}
		case '07': {
			obj.attr('minlen', maxlength);
			obj.inputmask('Regex', {regex: "^[0-9]+$"});
			obj.bind('blur', function () {
				var minlen = g_toNum(obj.attr('minlen'));
				if (obj.val().length > 0 && minlen > obj.val().length) {
					showModalMessage("Please enter at least {0}.", g_toStr(minlen));
					obj.val("");
					obj.focus();
				}
			});
			break;
		}
		default: {
			break
		}
	}
}
function lpad(str, maxLength, padding) {
	if (str.length >= maxLength) {
		return str;
	} else {
		var len = maxLength - str.length;
		var pad_str = str;
		for (var i = 0; i < len; i++)
			pad_str = padding + pad_str;

		return pad_str;
	}
}
function rpad(str, maxLength, padding) {
	if (str.length >= maxLength)
		return str;
	else {
		var len = maxLength - str.length;
		var pad_str = str;
		for (var i = 0; i < len; i++)
			pad_str = pad_str + padding;

		return pad_str;
	}
}

Date.prototype.format = function(_formatString) {
	var _result = this ;
	if (!!_formatString) {
		var hours24 = this.getHours() ;
		var hours = hours24 ;
		var _day = "AM" ;
		if (hours24 >= 12) {
			hours = hours24 - 12 ;
			_day = "PM" ;
		}
		_result = _formatString ;
		_result = _result.replace(/YYYY/gi, this.getFullYear().toString())
						 .replace(/YY/gi, this.getFullYear().toString().substr(2, 2))
						 .replace(/DD/gi, ((this.getDate() < 10) ? "0" : "") + this.getDate())
						 .replace(/D/gi, this.getDate())
						 .replace(/HH24/gi, ((hours24 < 10) ? "0" : "") + hours24)
						 .replace(/H24/gi, hours24)
						 .replace(/HH/gi, ((hours < 10) ? "0" : "") + hours)
						 .replace(/H/gi, hours)
						 .replace(/MI/g, ((this.getMinutes() < 10) ? "0" : "") + this.getMinutes())
						 .replace(/mi/g, this.getMinutes())
						 .replace(/SS/gi, ((this.getSeconds() < 10) ? "0" : "") + this.getSeconds())
						 .replace(/S/gi, this.getSeconds())
						 .replace(/MM/gi, ((this.getMonth() + 1 < 10) ? "0" : "") + (this.getMonth() + 1))
						 .replace(/M/gi, (this.getMonth() + 1))
						 .replace(/PP/gi, _day) ;
	}
	return _result ;
} ;
function gfn_removeSpacCharRegExr(str, regExp) {
    return str.replace(regExp, "");
}

Date.strToDate = function(_str, _format) {
	var _result = null ;
	if (!!_str && !!_format) {
		if (_str.length != _format.length) throw "FormatError: 날짜값과 포맷형식이 일치하지 않습니다." ;
		var _$tmpDate = new Date() ;
		var _year = _$tmpDate.getUTCFullYear(), _month = 0, _date = 1 ;
		if (_format.indexOf("YYYY") > -1) _year = parseInt(_str.substr(_format.indexOf("YYYY"), 4), 10) ;
		if (_format.indexOf("MM") > -1) _month = parseInt(_str.substr(_format.indexOf("MM"), 2), 10) - 1 ;
		if (_format.indexOf("DD") > -1) _date = parseInt(_str.substr(_format.indexOf("DD"), 2), 10) ;
		_result = new Date(Date.UTC(_year, _month, _date)) ;
	}
	return _result ;
} ;

Date.strToDate2 = function(_str, _format) {
	var _result = null ;
	if (!!_str && !!_format) {
		if (_str.length != _format.length) throw "FormatError: 날짜값과 포맷형식이 일치하지 않습니다." ;
		var _year = 0, _month = 0, _date = 0 ;
		if (_format.indexOf("YYYY") > -1) _year = parseInt(_str.substr(_format.indexOf("YYYY"), 4), 10) ;
		if (_format.indexOf("MM") > -1) _month = parseInt(_str.substr(_format.indexOf("MM"), 2), 10) ;
		if (_format.indexOf("DD") > -1) _date = parseInt(_str.substr(_format.indexOf("DD"), 2), 10) ;
		_result = new Date(Date.UTC(_year, _month, _date)) ;
	}
	return _result ;
};

String.prototype.lpad = function( maxLength, fillChar ) {
  var srcStr = this.substr( 0, maxLength );
  var cnt = 0;

  for( var inx = srcStr.length; inx < maxLength; inx++ ) {
    srcStr = fillChar.charAt(cnt) + srcStr;
    cnt++;
    cnt = ( cnt == fillChar.length ) ? 0 : cnt;
  }
  return srcStr;

};
String.prototype.getByte = function(utf8Yn) {
	var str = this.trim();

	var b = str.match(/[^\x00-\xff]/g);
    return (str.length + (!b ? 0: b.length));
};
String.prototype.isEmail = function() {
	var str = this.trim();
	if (fn_isNull(str))
		return true;
	return (/\w+([-+.]\w+)*@\w+([-.]\w+)*\.[a-zA-Z]{2,4}$/).test(str);
};

// set default period of datetime (month/day) follow program setting
function setDatePeriod(frDateId, toDateId) {
	var $frDate = $(frDateId);
    var $toDate = $(toDateId);
    var datePart = $frDate.attr('txtformat') == 'month' ? 'month' : 'day';
    var frDate;
    var toDate;

    var SCH_FR_STD_CD = CONST.SCH_FR_STD_CD ? CONST.SCH_FR_STD_CD : "01"; // 01:Current, 02:This month, 03:Last month, 04:End of Last month, 05:End of This month
    var SCH_TO_STD_CD = CONST.SCH_TO_STD_CD ? CONST.SCH_TO_STD_CD : "01";
    var SCH_FR_DY_STD = Number(CONST.SCH_FR_DY_STD ? CONST.SCH_FR_DY_STD : "0"); // 0: current date, 1..31: day of month
    var SCH_TO_DY_STD = Number(CONST.SCH_TO_DY_STD ? CONST.SCH_TO_DY_STD : "0");

    /* FROM DATE */
    switch (SCH_FR_STD_CD) {
		case "01" :
			frDate = g_dateAdd(g_today, SCH_FR_DY_STD, datePart);
			break ;
		case "02" :
			frDate = moment(g_today, 'YYYYMMDD').format('YYYYMM')+String(SCH_FR_DY_STD).lpad(2, '0');
			if(!g_isDateYmd(frDate)){
				frDate = g_today;
			}
			break ;
		case "03" :
			frDate = moment(g_today, 'YYYYMMDD').add(g_toNum(-1), 'month').format('YYYYMM') + String(SCH_FR_DY_STD).lpad(2, '0');
			if(!g_isDateYmd(frDate)){
				frDate = g_today;
			}
			break ;
		case "04" :
			frDate = moment().date(0).format('YYYYMMDD');
			break ;
		case "05" :
			frDate = moment().add('months', 1).date(0).format('YYYYMMDD');
			break ;
		default :
			frDate = g_today;
			break ;
    }

    /* TO DATE */
    switch (SCH_TO_STD_CD) {
	    case "01" :
	    	toDate = g_dateAdd(g_today, SCH_TO_DY_STD, datePart);
	    	break ;
	    case "02" :
	    	toDate = moment(g_today, 'YYYYMMDD').format('YYYYMM')+String(SCH_TO_DY_STD).lpad(2, '0');
	    	if(!g_isDateYmd(toDate)){
	    		toDate = g_today;
	    	}
	    	break ;
	    case "03" :
	    	toDate = moment().date(0).format('YYYYMM') + String(SCH_TO_DY_STD).lpad(2, '0');
	    	if(!g_isDateYmd(toDate)){
	    		toDate = g_today;
	    	}
	    	break ;
	    case "04" :
	    	toDate = moment().date(0).format('YYYYMMDD');
	    	break ;
	    case "05" :
	    	toDate = moment().add('months', 1).date(0).format('YYYYMMDD');
			break ;
	    default :
	    	toDate = g_today;
	    	break ;
    }

	if (datePart == 'month') {
		frDate = g_left(frDate, 6);
		toDate = g_left(toDate, 6);
	}

    $frDate.val(frDate);
    $toDate.val(toDate);
};

function setTxtFormat(type, value) {
	if (gfn_isNull(type) || gfn_isNull(value)) {
		return "";
	}
	if (type == "date" || type == "monthday" || type == "month") {
		var date_format = "";
		if (!gfn_isIncludeSpecChar(value)) {
			if (type == "date") {
				date_format = g_localeOptions.dateFormat_nm.indexOf("yyyy") > -1 ? g_localeOptions.dateFormat_nm.replace(/yyyy/g, 'yy') : g_localeOptions.dateFormat_nm;
				value = $.datepicker.formatDate(date_format, new Date(moment(gfn_checkValidDate(value), 'YYYYMMDD')));
			} else if (type == "monthday") {
				value = $.datepicker.formatDate(g_localeOptions.mmddFormat, new Date(moment(gfn_checkValidYear(value), 'YYYYMMDD')));
			} else if (type == "month"	) {
				date_format = g_localeOptions.yymmFormat.indexOf("yyyy") > -1 ? g_localeOptions.yymmFormat.replace(/yyyy/g, 'yy') : g_localeOptions.yymmFormat;
				value = $.datepicker.formatDate(date_format, new Date(moment(gfn_checkValidDay(value), 'YYYYMMDD')));
			}
		}
	}
	return value;
}
// if input is datepicker - trigger change when val(new_val) is called (even if the value didn't actually changed)
(function ($) {
	var originalVal = $.fn.val;
	$.fn.val = function(value) {
		if (typeof value != 'undefined') {
			if($(this).is('input:text') && $(this).attr("txtformat") != undefined){
				if (!gfn_isNull(value)) {
					if ($(this).attr("txtformat") == "date" || $(this).attr("txtformat") == "monthday" || $(this).attr("txtformat") == "month") {
						var preVal = value;
						if (!gfn_isIncludeSpecChar(preVal)) {
							value = setTxtFormat($(this).attr("txtformat"), value);
							if ($(this).attr("txtformat") == "date") {
								$(this).datepicker( "setDate" , new Date(moment(gfn_checkValidDate( preVal ), 'YYYYMMDD')));
							} else if ($(this).attr("txtformat") == "monthday") {
								$(this).datepicker( "setDate" , new Date(moment(gfn_checkValidYear( preVal ), 'YYYYMMDD')));
							} else if ($(this).attr("txtformat") == "month"	) {
								$(this).datepicker( "setDate" , new Date(moment(gfn_checkValidDay( preVal ), 'YYYYMMDD')));
							}
						}
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