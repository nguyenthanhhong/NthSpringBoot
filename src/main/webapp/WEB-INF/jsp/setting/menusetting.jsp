<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fo" uri="/WEB-INF/resources/tag/custom-tag.tld"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<div class="page-content container-fluid">
    <div class="row">
        <div class="col-lg-6">
            <!-- Example Panel With Heading -->
            <div class="panel">
                <div class="panel-heading pdt-8">
                    <h5 class="panel-title">
                        <i class="fa fa-chevron-circle-right"></i>Menu List
                    </h5>
                    <div class="panel-actions">
                        <button type="button" onclick="collapseTreeClick()" class="btn btn-icon btn-danger btn-sm"><i class="icon fa fa-compress" aria-hidden="true"></i></button>
                        <button type="button" onclick="expandTreeClick()" class="btn btn-icon btn-danger btn-sm"><i class="icon fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="panel-body">
                    <div id="treeArea" style="height: 440px;">
                        <ul></ul>
                    </div>
                </div>
            </div>
            <!-- End Example Panel With Heading -->
        </div>

        <div class="col-lg-6">
            <div class="panel">
                <div class="panel-heading pdt-8">
                    <h5 class="panel-title">
                        <i class="fa fa-chevron-circle-right"></i>Detail Information
                    </h5>
                </div>
                <div class="panel-body">
                    <form name="frmDetail" id="frmDetail">
                        <table>
                            <tr>
                                <th><span class="star"></span><spring:message code="MNU_CD" /></th>
                                <td colspan="3">
                                    <input type="text" class="form-control" name="PRG_CD" id="PRG_CD" readonly/>
                                    <input type="hidden" class="form-control" name="MENU_YN" id="MENU_YN"/>
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="MNU_NM" /></th>
                                <td colspan="3">
                                    <input type="text" class="form-control" name="PRG_NM" id="PRG_NM" required/>
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="NOTE" /></th>
                                <td colspan="3">
                                    <input type="text" class="form-control" name="NOTE" id="NOTE" />
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="DB_CD" /></th>
                                <td>
                                    <fo:codeList outType="select" cmCd="DATABASE" name="DB_CD" selectDefaultName="Select" required="true" cssClass="form-control"/>
                                </td>
                                <th><span class="star"></span><spring:message code="USE_YN" /></th>
                                <td>
                                    <div class="input-group">
                                        <label class="chkArea"><input type="radio" name="USE_YN" value="1"><span></span><spring:message code="YES" /></label>
                                        <label class="chkArea"><input type="radio" name="USE_YN" value="0"> <span></span><spring:message code="NO" /></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="MNU_URL" /></th>
                                <td colspan="3">
                                    <input type="text" class="form-control" name="PRG_URL" id="PRG_URL"/>
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="LOCAL_URL" /></th>
                                <td colspan="3">
                                    <input type="text" class="form-control" name="LOCAL_URL" id="LOCAL_URL"/>
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="SCH_TERM" /></th>
                                <td colspan="3">
                                    <input type="text" class="form-control" name="SCH_TERM" id="SCH_TERM" />
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="SCH_FR_CD" /></th>
                                <td>
                                    <fo:codeList outType="select" cmCd="DATE_PD" name="SCH_FR_CD" cssClass="form-control" selectDefaultName="Select"/>
                                </td>
                                <th><span class="star"></span><spring:message code="SCH_FR_DT" /></th>
                                <td>
                                    <input type="text" class="form-control" name="SCH_FR_DT" />
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="SCH_TO_CD" /></th>
                                <td>
                                    <fo:codeList outType="select" cmCd="DATE_PD" name="SCH_TO_CD" cssClass="form-control" selectDefaultName="Select"/>
                                </td>
                                <th><span class="star"></span><spring:message code="SCH_TO_DT" /></th>
                                <td>
                                    <input type="text" class="form-control" name="SCH_TO_DT" />
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="BTN1_NM" /></th>
                                <td>
                                    <input type="text" class="form-control" name="BTN1_NM" id="BTN1_NM" />
                                </td>
                                <th><span class="star"></span><spring:message code="BTN2_NM" /></th>
                                <td>
                                    <input type="text" class="form-control" name="BTN2_NM" id="BTN2_NM" />
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="BTN3_NM" /></th>
                                <td>
                                    <input type="text" class="form-control" name="BTN3_NM" id="BTN3_NM" />
                                </td>
                                <th><span class="star"></span><spring:message code="BTN4_NM" /></th>
                                <td>
                                    <input type="text" class="form-control" name="BTN4_NM" id="BTN4_NM" />
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="BTN5_NM" /></th>
                                <td>
                                    <input type="text" class="form-control" name="BTN1_NM" id="BTN5_NM" />
                                </td>
                                <th><span class="star"></span><spring:message code="BTN6_NM" /></th>
                                <td>
                                    <input type="text" class="form-control" name="BTN6_NM" id="BTN6_NM" />
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="BTN7_NM" /></th>
                                <td>
                                    <input type="text" class="form-control" name="BTN7_NM" id="BTN7_NM" />
                                </td>
                                <th><span class="star"></span><spring:message code="BTN8_NM" /></th>
                                <td>
                                    <input type="text" class="form-control" name="BTN8_NM" id="BTN8_NM" />
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="BTN9_NM" /></th>
                                <td>
                                    <input type="text" class="form-control" name="BTN9_NM" id="BTN9_NM" />
                                </td>
                                <th><span class="star"></span><spring:message code="BTN10_NM" /></th>
                                <td>
                                    <input type="text" class="form-control" name="BTN10_NM" id="BTN10_NM" />
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    let currentNode;
    const frm = $("#frmDetail");
    const tree = $("#treeArea");
    function documentReady() {
        setEvent();
        setTree();
        button1OnClick();
    }
    function setEvent() {
        frm.find("input, select").change(function (e) {
            var node = tree.fancytree("getActiveNode");

            if (node) {
                node.setSelected(true);

                var eachKey = $(this).attr("name");

                if ($(this).attr('type') && $(this).attr('type').toUpperCase() == 'CHECKBOX') {
                    node.data[eachKey] = ($(this).is(':checked') ? '1' : '0');
                } else {
                    node.data[eachKey] = $(this).val();
                }

                if (node.data._rowStatus != 'I') {
                    node.data._rowStatus = 'U';
                }

                if (eachKey == "PRG_NM") {
                    node.setTitle($(this).val());
                }
            }
        });
    }
    function setTree() {
        tree.fancytree({
            extensions: ["dnd", "edit", "glyph"],
            checkbox: true,
            icon: true,
            glyph: {
                // The preset defines defaults for all supported icon types.
                // It also defines a common class name that is prepended (in this case 'fa ')
                preset: "awesome4",
                map: {
                    // Override distinct default icons here
                    folder: "fa-folder",
                    folderOpen: "fa-folder-open",
                    doc: "fa-file",
                    docOpen: "fa-file",
                }
            },

            click: function (event, data) {
                if (data.targetType === "checkbox") {
                    return false;
                }

                return;
            },

            activate: function (event, data) {
                if (data.node) {
                    setRightData(data.node.data);
                    currentNode = data.node;
                }
            },

            createNode: function (event, data) {
                let node = data.node;
                if (node.data.PRG_CD == "") {
                    node.setSelected(true);
                    node.setActive(true);
                    setRightData(node.data);
                }
            },

            dnd: {
                autoExpandMS: 400,
                focusOnClick: false,
                preventVoidMoves: true,
                preventRecursiveMoves: true,
                dragStart: function (node, data) {
                    var changedNode = $('#treeArea').fancytree("getTree").getSelectedNodes();

                    if (changedNode.length == 0) {
                        return true;
                    } else {
                        fn_showMessage("Please use drag and drop after saving change(s).");
                        return false;
                    }

                },

                dragEnter: function (node, data) {
                    return true;
                },

                dragDrop: function (node, data) {
                    var onode = data.otherNode;
                    var onodeOldParent = onode.parent;

                    onode.moveTo(node, data.hitMode);

                    if (onodeOldParent.getChildren() == null) {
                        onodeOldParent.folder = false;
                        onodeOldParent.render();
                    }

                    node.setExpanded(true);
                    onode.setActive(true);

                    onode.data._rowStatus = 'U';

                    if (data.hitMode == "over") {
                        onode.data.P_PRG_CD = node.data.PRG_CD;
                        saveDnd(node.children, data.hitMode);
                    } else {
                        onode.data.P_PRG_CD = node.data.P_PRG_CD;
                        saveDnd(node.parent.children, data.hitMode);
                    }
                }
            }
        });
    }
    function saveDnd(changedNode, hitMode) {
        currentNode = tree.fancytree("getActiveNode");
        var ds_save = [];

        $.each(changedNode, function (index, node) {

            if (node.data.LVL != index + 1 || node.data._rowStatus == 'U') {
                node.data.LVL = index + 1;
                node.data._rowStatus = 'U';
                ds_save.push(node.data);
            }

        });

        var input = {
            id : "saveMenu",
            type : "SQL_UPDATE",
            params : {
                function:"MenuSettingService.updateMenu",
                data: ds_save
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }

    function setRightData(treeData) {
        frm.populateToForm(treeData);
    }

    function chkData() {
        if (!frm.checkFormValidation()) {
            return false;
        }
        return true;
    }

    function button1OnClick(){
        var input = {
            id : "search",
            type : "SQL_MULTI",
            params : {
                function: "MenuSettingService.getProgramList",
                data: "1=1"
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }

    function tranCallBack(id, data, errorCode, errorMessage) {
        if(errorCode != 0){
            fn_showMessage(errorMessage,"", "error");
            return;
        }
        if(id == "search") {
            $('#treeArea').createFancyTree(data, "PRG_NM", "PRG_CD", "P_PRG_CD", currentNode);
        }
        if(id == "save") {
            button1OnClick();
            return;
        }
    }

    function expandTreeClick() {
        tree.setExpanded(true);
    }

    function collapseTreeClick() {
        tree.setExpanded(false);
    }

    /**
     * Add tree node
     */
    function button2OnClick(){
        var node = tree.fancytree("getActiveNode");
        if (!node) {
            fn_showMessage("Please select 1 {0}", 'menu');
            return;
        }

        if (node.data.PRG_CD == "") {
            fn_showMessage("Program code does not exist on selected tree node.<br>You can add after saving.");
            return;
        }

        var lastNode = node.getLastChild();
        var lastLvl = 1;
        if (lastNode) {
            lastLvl = lastNode.data.LVL + 1;
        }

        var newData = {
            title: "New Menu",
            data: {
                PRG_CD: "",
                PRG_NM: "New Menu",
                DB_CD: "01",

                LVL: lastLvl,
                P_PRG_CD: node.data.PRG_CD,

                USE_YN: '1',
                MENU_YN: '1',

                _rowStatus: "I"
            }
        };

        node.addChildren(newData);
        node.folder = true;
        node.setExpanded(true);
        node.render();
    }

    /**
     * Remove new tree node
     */
    function button3OnClick(){
        var node = tree.fancytree("getActiveNode");
        if (!node) {
            fn_showMessage("Please select a program.");
            return;
        }

        fn_showConfirm('Delete?').then(function (answer) {
            if (answer) {
                if (node.data.PRG_CD == "") {
                    if (node.parent.getChildren().length === 1) {
                        node.parent.folder = false;
                        node.parent.render();
                    }
                    node.remove();
                } else {
                    fn_showMessage('Only new row(s) can be deleted.');
                    return;
                }
            } else {
                return;
            }
        });
    }

    /**
     * Save tree node
     */
    function button4OnClick(){
        if (!chkData()) {
            return;
        }

        let ds_save = tree.getFancyTreeData();
        if (ds_save.length == 0) {
            fn_showMessage("No changes");
            return;
        }

        var input = {
            id : "save",
            type : "SQL_PROC",
            params : {
                function: "MenuSettingService.saveProgram",
                data: ds_save
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }
</script>