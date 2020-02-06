function fn_showConfirm(msg, params) {
	msg = parseMsgParams(msg, params);
	var defer = $.Deferred();
	var html = '<div id="dialogConfirm">' + msg + '</div>';

	$(html).dialog({
		autoOpen : true,
		close : function() {
			$(this).dialog('destroy');
			defer.resolve(false);
		},
		modal : true,
		draggable : false,
		resizable : false,
		title : 'Confirm',
		width : 400,
		buttons : {
			OK : function() {
				$(this).dialog('destroy');
				defer.resolve(true);
			},
			CANCEL : function() {
				$(this).dialog("close");
				defer.resolve(false);
			}
		}
	});
	parseMsgClass($(".ui-dialog"), "modal-primary");
	return defer.promise();
}

function fn_showModalMessage(msg, title, cssClass) {
	var defer = $.Deferred();

	var html = '<div id="dialog">' + msg + '</div>';

    $(html).dialog({
        autoOpen: true,
        close: function () {
            $(this).dialog('destroy');
        },
        modal: true,
        draggable: false,
        resizable : false,
        title: title,
        width : 400,
        buttons: {
	        OK: function() {
	          $( this ).dialog( "close" );
	          defer.resolve(true);
	        }
        }
	});
	parseMsgClass($(".ui-dialog"), cssClass);
	return defer.promise();
}

function parseMsgParams(message, bindInfo) {
	var arrBind;
	if (bindInfo != null && bindInfo.length > 0) {
		arrBind = bindInfo.split("|");
		for (let i = 0; i < arrBind.length; i++) {
			message = message.replace("{" + i + "}", arrBind[i]);
		}
	}
	return message;
}

function parseMsgClass($dialog, cssClass) {
	$dialog.addClass("modal-content " + cssClass);
	$dialog.find(".ui-dialog-titlebar").addClass("modal-header").find(".ui-button").addClass("close").text("x");
	$dialog.find(".ui-dialog-content").addClass("modal-body");
	$dialog.find(".ui-dialog-buttonpane").addClass("modal-footer").find(".ui-button").addClass("btn btn-primary");
}

function fn_showMessage(msg, params, messType) {
	msg = parseMsgParams(msg, params);
	switch(messType) {
		case "info":
			fn_showModalMessage(msg, "Information", "modal-primary");
			break;
		case "warning":
			fn_showModalMessage(msg, "Warning", "modal-warning");
			break;
		case "error":
			fn_showModalMessage(msg, "Error", "modal-danger");
			break;
		case "confirm":
			fn_showConfirm(msg);
			break;
		default:
			fn_showModalMessage(msg, "Information","modal-primary");
	}
}