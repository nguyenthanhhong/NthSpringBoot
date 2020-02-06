function transaction(input){
    let url = "/" + FUNCTION[input.type];
    if(!url) {
        alert("wrong type");
        return;
    }
    $.ajax({
        method: 'POST',
        url: url,
        data: JSON.stringify(input.params),
        contentType: "application/json",
        beforeSend : function(jqXHR, settings) {
            openLoadingImage(input.isLoad);
        },
        complete : function(jqXHR, textStatus) {
            closeLoadingImage();
            var returnData;
            try {
                returnData = JSON.parse(jqXHR.responseText);
            } catch (e) {
                returnData = {
                    errorCode : -1,
                    errorMessage : '-1'
                };
            }
            if($.isFunction(input.callBack)){
                input.callBack(input.id, returnData["data"], returnData.errorCode, returnData.errorMessage);
            }
        }
    });
};

function openLoadingImage(isLoad) {
    if(!isLoad) {return;}

    $.blockUI({
        message : '<div class="egg_loader"></div>',
        css : {
            top:  ($(window).height() - 400) /2 + 'px',
            left: ($(window).width() - 400) /2 + 'px',
            width: '400px' ,
            border : 'none',
            backgroundColor : 'transparent',
            opacity : 1
        },
        overlayCSS : {
            opacity : 0,
            cursor : 'wait'
        }
    });
};

function closeLoadingImage() {
    $.unblockUI();
};

/**
 * open report window
 * @param input: {reportName: "", data: "", function: ""}
 */
function fn_openPdfReport(input) {
    let url = "/main/" + PAGE_INFO.DB_SOURCE + "/exportReport";
    OpenWindowWithPost(url, "width=1000, height=600, left=100, top=100, resizable=yes, scrollbars=yes", input["reportName"], input);
}

function fn_openExcelReport(input) {
    let url = "/main/" + PAGE_INFO.DB_SOURCE + "/exportExcelFile";
    OpenWindowWithPost(url, "width=1000, height=600, left=100, top=100, resizable=yes, scrollbars=yes", input["reportName"], input);
}

function OpenWindowWithPost(url, windowoption, name, params) {
    var form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", url);
    form.setAttribute("target", name);
    for (var i in params) {
        if (params.hasOwnProperty(i)) {
            var input = document.createElement('input');
            input.type = 'hidden';
            input.name = i;
            if(typeof (params[i]) == "object") {
                input.value = JSON.stringify(params[i]);
            }else {
                input.value = params[i];
            }
            form.appendChild(input);
        }
    }
    document.body.appendChild(form);
    //note I am using a post.htm page since I did not want to make double request to the page
    //it might have some Page_Load call which might screw things up.
    //window.open("jpreport.jsp", name, windowoption); --dua vo nhung deo duoc nhu test :( mo them 1 tab nua huhuhu)
    form.submit();
    document.body.removeChild(form);
}