function gfn_popup(opt) {
  var options = {
    popupOpts: {
      width: 900,
      height: 600
    },
    resizable: false,
    scrollyn: true
  };

  $.extend(options, opt);

  layerPopup(options);
}
function layerPopup(o) {
  //Just in case, we don't have any dialog was initialized.
  try {
    $("#" + o.popupName).dialog("destroy");
  } catch (e) {}
  var optFirst = {};

    $.extend(optFirst,o);

    //alert("layerPopup() o.value?"+JSON.stringify(o));

    var optDefault = {
        isGrid: false,   //그리드에서 호출할 경우 true
        grdId: null,     //isGrid가 true일 경우에만 유효
        rowId: null,     //isGrid가 true일 경우에만 유효
        //searchUrl: CONST.CONTEXT_PATH + "/common/syscommon/commonPage/searchPost.fo", //그리드 조회 URL
        popupUrl: o.strUrl,    //호출 URL
        popupNm: o.popupName , //팝업윈도우 name
        popupWidth: o.popupOpts.width,       //팝업 가로크기(없으면 기본값)
        popupHeight:o.popupOpts.height,      //팝 업 세로크기(없으면 기본값)
        popupType:"MODAL",
        title : o.popupOpts.title,  //자동 설정 처리 됨.
        autoOpen:true,
        resizable:(optFirst.resizable || false),
        draggable: (optFirst.draggable || true)
        //mappingArr의 구조
        //  elemId - 그리드칼럼명 or html엘리먼트 id (필수)
        //  rsNm - 쿼리의 결과 칼럼명 or Alias (필수)
        //  paramNm - 쿼리의 파라미터로 쓰여야 할 경우, 파라미터명을 지정 (선택)
        //  popElemId - 검색팝업의 조회조건으로 써야할 경우 팝업에서 해당id를 갖는 input에 바인딩하기 위해 선언(선택)
        //  noClear - true : mappingArr에 정의한  폼엘리먼트의 값을 초기화하지 않는다. (선택)
        // 검색 조건으로 추가할 파라미터
    };

    $.extend(optFirst, optDefault);

    commonPopup(optFirst); //팝업 호출
  $.extend(optFirst, o);

}
function commonPopup(o) {
  //alert("commonPopup()?"+JSON.stringify(o)) ;

  if (typeof o.mappingArr == "undefined" || o.mappingArr == null) {
  } else {
    //현재시점의 폼엘리먼트 혹은 그리드의 초기데이터를 mappingArr에 바인딩
    setArrFromHtml(o);
  }

  //기존 o에서 param으로 보낼 것만 추출
  var po = {};

  po["popupType"] = o["popupType"];

  po["title"] = o["title"];

  po["isGrid"] = o["isGrid"];

  po["grdId"] = o["grdId"];

  po["rowId"] = o["rowId"];

  po["mappingArr"] = o["mappingArr"];

  po["userFunc"] = o["userFunc"];

  po["USER_FUNC"] = o["userFunc"];

  po["POPUP_NM"] = o["popupNm"];

  po["searchParam"] = o["searchParam"];

  //기존 로직과 구분 처리한다.
  po["callType"] = "NEW";

  if (po["popupType"] == "MODAL") {
    po["popupId"] = o["popupNm"];
  } else {
    po["popupType"] = "WIN";
  }

  var poJSON = JSON.stringify(po);

  setTimeout(function() {
    if (o.popupType == "MODAL") {
      o["param"] = { po: poJSON };
      //Dialog 팝업으로 호출
      openFrameModal(o);
    } else {
      var options = {
        windowName: o.popupNm, // name of window
        windowURL: o.popupUrl,
        width: o.popupWidth, //사용자정의값 우선
        height: o.popupHeight,
        param: { po: poJSON }
      };

      //Window Log 팝업으로 호출
      openNormalPopup(options);
    }
  }, 0);
}
function openNormalPopup(popOptions) {
  //alert("openNormalPopup 최초받은 popOptions?"+popOptions);
  //Popup Window Default 옵션
  var defaultPopupOptions = {
    width: 500, // sets the width in pixels of the window.
    height: 500, // sets the height in pixels of the window.
    centerScreen: 1, // center window over entire screen {1 (YES) or 0 (NO)}. overrides top and left
    left: 0, // left position when the window appears.
    location: 0, // determines whether the address bar is displayed {1 (YES) or 0 (NO)}.
    menubar: 0, // determines whether the menu bar is displayed {1 (YES) or 0 (NO)}.
    resizable: 0, // whether the window can be resized {1 (YES) or 0 (NO)}. Can also be overloaded using resizable.
    scrollbars: 1, // determines whether scrollbars appear on the window {1 (YES) or 0 (NO)}.
    status: 0, // whether a status line appears at the bottom of the window {1 (YES) or 0 (NO)}.
    windowName: null, // name of window set from the name attribute of the element that invokes the click
    windowURL: null, // url used for the popup
    top: 0, // top position when the window appears.
    toolbar: 0, // determines whether a toolbar (includes the forward and back buttons) is displayed {1 (YES) or 0 (NO)}.
    alwaysRaised: 1, // Always in front of all other browser windows. Signed script required.
    dependent: 1, // Subwindow closes if the window that opened it closes.
    location: 0,
    directories: 0
  };

  var settings = $.extend(defaultPopupOptions, popOptions);

  // Safari, Chrome 팝업창 높이 조정
  // Sarari는 IE에 비해 팝업창이 크게 뜨고, Chrome은 팝업창이 작게떠서 크기 조정.
  var app_version = navigator.appVersion.toUpperCase();
  if (app_version.indexOf("CHROME") >= 0) {
    settings.height = parseInt(settings.height, 10) + 5;
  } else if (app_version.indexOf("SAFARI") >= 0) {
    settings.height = parseInt(settings.height, 10) - 75;
  }

  // PopupWindow 중앙 출력
  if (settings.centerScreen) {
    if (getBrowser().indexOf("IE") >= 0) {
      //hacked together for IE browsers
      settings.top =
        window.screenTop -
        120 +
        ((document.documentElement.clientHeight + 120) / 2 -
          settings.height / 2);
      settings.left =
        window.screenLeft +
        ((document.body.offsetWidth + 20) / 2 - settings.width / 2);

      if (settings.centerScreen == 2) {
        settings.top = 230;
        settings.left =
          window.screenLeft +
          ((document.body.offsetWidth + 20) / 2 - settings.width / 2);
      }
    } else {
      settings.top =
        window.screenY + (window.outerHeight / 2 - settings.height / 2);
      settings.left =
        window.screenX + (window.outerWidth / 2 - settings.width / 2);
    }
  }

  var windowFeatures =
    "height=" +
    settings.height +
    ",width=" +
    settings.width +
    ",left=" +
    settings.left +
    ",top=" +
    settings.top +
    ",location=" +
    settings.location +
    ",menuBar=" +
    settings.menubar +
    ",resizable=" +
    settings.resizable +
    ",scrollbars=" +
    settings.scrollbars +
    ",status=" +
    settings.status +
    ",toolbar=" +
    settings.toolbar +
    ",alwaysRaised=" +
    settings.alwaysRaised +
    ",dependent=" +
    settings.dependent +
    ",directories=" +
    settings.directories +
    ",titlebar=no,location=0,menubar=0 ";

  // 파라메터값 생성
  var param = "";
  var cntParam = 0;
  for (variable in settings.param) {
    if (cntParam == 0) param += "?";
    else param += "&";

    //param += variable + "=" + encodeURIComponent(settings.param[variable]); //Prameter Add

    param += variable + "=" + encodeURIComponent(settings.param[variable]); //Prameter Add

    var tempData = encodeURIComponent(settings.param[variable]);

    //alert("for(variable in settings.param) ? encodeURIComponent?"+tempData+",decodeURIComponent?"+decodeURIComponent(tempData));

    cntParam++; // Count
  }

  settings.windowURL = settings.windowURL + param;

  //IE(?)에서 window.open()에서 윈도우 명에 공백이나 특수문자가 들어가면 팝업 자체가 뜨지 않으므로 공백/특수문자를 제거한다.
  if (settings.windowName != null && settings.windowName.length > 0) {
    settings.windowName = settings.windowName.replace(
      /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"\s]/gi,
      ""
    );
  }

  var objWin = window.open(
    settings.windowURL,
    settings.windowName,
    windowFeatures
  );

  if (objWin == null) {
    // 팝업차단 : failed for most browsers
    //showMessage("ERR_POPBLOCK");
    showMessage("MSG_COM_ERR_043");
  } else {
    setTimeout(function() {
      if (objWin.innerHeight === 0) {
        // 팝업차단 : failed for chrome
        //showMessage("ERR_POPBLOCK");
        showMessage("MSG_COM_ERR_043");
      } else {
        objWin.focus();
      }
    }, 100);
  }
  return objWin;
}
function getBrowser() {
  var agent = navigator.userAgent.toUpperCase();
  if (agent.indexOf("MSIE") >= 0) {
    if (agent.indexOf("MSIE 7.0") >= 0) {
      return "IE_7";
    } else if (agent.indexOf("MSIE 8.0") >= 0) {
      return "IE_8";
    } else if (agent.indexOf("MSIE 9.0") >= 0) {
      return "IE_9";
    } else {
      return "IE"; //기타 버전
    }
  } else if (agent.indexOf("FIREFOX") >= 0) {
    return "FIREFOX";
    //크롬과 사파리는 같이 웹킷을 사용하기 때문에 크롬을 찾는 구문이 위에 있어야 한다.
  } else if (agent.indexOf("CHROME") >= 0) {
    return "CHROME";
  } else if (agent.indexOf("SAFARI") >= 0) {
    return "SAFARI";
  } else if (agent.indexOf("OPERA") >= 0) {
    return "OPERA";
  } else {
    // 2014.03.07 shks
    // IE 11에서 MSIE 문자열이 제거됨
    // if ~ else if ~ else 에서 else가 누락되어 추가

    return "";
  }
}
function openFrameModal(o) {
  var defer = $.Deferred();
  var headerClass = "bgPacony"; //$("body" , parent.document).attr("class");

  // if(!headerClass){
  //     headerClass = "bgPacony";
  // }

  $("body").addClass(headerClass);

  var modaltmpl = "";
  var scrolling = o.scrolling || "no";

  var height = o.popupHeight;
  var app_version = navigator.appVersion.toUpperCase();
  var scrollyn = o.scrollyn;

  if (height > 700) {
    height = 700;
    scrollyn = true;
  }

  modaltmpl =
    "<div id='#[popupId]' style='width:100%;height:100%;border:none;  overFlow : visible; ' scrolling='no' >";
  modaltmpl +=
    "<iframe id='FO_MODAL_IF-#[popupId]' name='FO_MODAL_IF-#[popupId]' src='#[popupUrl]' frameborder='0' style='width:100%;height:100%;border:none; overFlow : visible; ' scrolling='" +
    scrolling +
    "'></iframe>";
  modaltmpl += "</div>";

  if (scrollyn) {
    modaltmpl = "";
    modaltmpl =
      "<div id='#[popupId]' style='width:100%;height:100%;border:none;  overFlow : visible; ' scrolling='no'  ' >";
    modaltmpl +=
      "<iframe id='FO_MODAL_IF-#[popupId]' name='FO_MODAL_IF-#[popupId]' src='#[popupUrl]' frameborder='0' style='width:100%;height:100%;border:none; ' ></iframe>";
    modaltmpl += "</div>";
  }

  var defaultDialogOpts = {
    //autoOpen : true,
    width: o.popupWidth, //사용자정의값 우선
    height: height,
    modal: true,
    closeOnEscape: true,
    resizable: true,
    title: o.title,
    draggable: false,
    buttons: {},
    open: function(ev, ui) {},
    close: function(ev, ui) {}
  };

  // 파라메터값 생성
  var param = "";
  var cntParam = 0;
  //debugger
  $.extend(o.param, { POPUP_NM: o.popupName });

  if (o.method == "POST") {
    $(modaltmpl.replace(/#\[popupId\]/g, o.popupNm))
      .dialog($.extend(defaultDialogOpts, o))
      .parents(".ui-dialog")
      .find(".ui-dialog-titlebar")
      .addClass(headerClass);
    var $form = $("<form></form>");
    $form.attr("action", o.popupUrl);
    $form.attr("method", "post");
    $form.attr("target", "FO_MODAL_IF-" + o.popupNm);
    $form.appendTo("body");

    var postAjaxData = $('<input name="__postAjaxData__" type="hidden" />');
    postAjaxData.val(JSON.stringify(o.param));
    $form.append(postAjaxData);
    $form.submit();
  } else {
    for (variable in o.param) {
      if (cntParam == 0) param += "?";
      else param += "&";
      param += variable + "=" + encodeURIComponent(o.param[variable]); //Prameter Add
      cntParam++; // Count
    }

    $(
      modaltmpl
        .replace(/#\[popupId\]/g, o.popupNm)
        .replace(/#\[popupUrl\]/g, o.popupUrl + param)
    )
      .dialog($.extend(defaultDialogOpts, o))
      .parents(".ui-dialog")
      .find(".ui-dialog-titlebar")
      .addClass(headerClass);
  }
  return defer.promise(); //important to return the defer promise
}
function setArrFromHtml(o) {
  //alert("setArrFromHtml START!");

  for (var i = 0; i < o.mappingArr.length; i++) {
    var mappingObj = o.mappingArr[i];

    var elemId = mappingObj["elemId"];

    var val = $.trim(getHtmlVal(o, elemId));

    //alert("setArrFromHtml() elemId?"+elemId+" val?"+val);

    if (val.length === 0) {
      continue;
    }
    mappingObj["initVal"] = val;
  }
  //alert("bindMappingArr END!");
}
function getHtmlVal(o, elemId) {
  var val;

  val = $("#" + elemId).val();

  return val;
}
function closeLayer(popupName, resultData, userFunc) {
  popupName = "#" + popupName;

  if (parent.$(popupName).dialog("isOpen") == true) {
    setTimeout(function() {
      parent.$(popupName).dialog("close");

      parent.$(popupName).dialog("destroy");
    }, 0);

    // 코드 검색 후 실행할 사용자 정의 함수 호출(조회 결과값 Data를 parameter로  넘김)
    var fn_user = eval("parent." + userFunc);

    if ($.isFunction(fn_user)) {
      //alert("parent Function 존재함.");
      fn_user(resultData);
    }

    return true;
  } else {
  }
}
