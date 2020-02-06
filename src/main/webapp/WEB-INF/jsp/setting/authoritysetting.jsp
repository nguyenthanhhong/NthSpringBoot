<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="fo" uri="/WEB-INF/resources/tag/custom-tag.tld"%>
<div class="page-content container-fluid">
    <div class="panel">
        <table>
            <tr>
                <th><span class="star"></span><spring:message code="Program List" /></th>
                <td>
                    <fo:select id="P_PRG_CD" name="P_PRG_CD" sqlId="getProgramList" selectedValue="" selectDefaultName="Select" required="true" cssClass="form-control"/>
                </td>
            </tr>
        </table>
    </div>
    <div class="row">
        <div class="col-lg-6">
            <!-- Example Panel With Heading -->
            <div class="panel">
                <div class="panel-heading pdt-8">
                    <h5 class="panel-title">
                        <i class="fa fa-chevron-circle-right"></i>Program detail
                    </h5>
                </div>
                <div class="panel-body">
                    <form name="frmDetail" id="frmDetail">
                        <table>
                            <tr>
                                <th><span class="star"></span><spring:message code="PRG_CD" /></th>
                                <td>
                                    <input type="text" class="form-control" name="PRG_CD" id="PRG_CD" readonly/>
                                    <input type="hidden" class="form-control" name="MENU_YN" id="MENU_YN"/>
                                </td>
                                <th><span class="star"></span><spring:message code="PRG_NM" /></th>
                                <td>
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
                                <th><span class="star"></span><spring:message code="PRG_URL" /></th>
                                <td colspan="3">
                                    <input type="text" class="form-control" name="PRG_URL" id="PRG_URL" required/>
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="LOCAL_URL" /></th>
                                <td colspan="3">
                                    <input type="text" class="form-control" name="LOCAL_URL" id="LOCAL_URL" required/>
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
                                    <fo:codeList outType="select" cmCd="DATE_PD" name="SCH_TO_CD" selectDefaultName="Select" cssClass="form-control"/>
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
            <!-- End Example Panel With Heading -->
        </div>

        <div class="col-lg-6">
            <!-- Example Panel With Footer -->
            <div class="panel">
                <div class="panel-heading pdt-8">
                    <h5 class="panel-title">
                        <i class="fa fa-chevron-circle-right"></i>Program authority
                    </h5>
                    <div class="panel-actions">
                        <button type="button" id="btnAdd" class="btn btn-icon btn-danger btn-sm" onclick="btnAddRoleClick()"><i class="icon fa fa-plus" aria-hidden="true"></i></button>
                        <button type="button" id="btnDel" class="btn btn-icon btn-danger btn-sm" onclick="btnDelRoleClick()"><i class="icon fa fa-minus" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div id="grid"></div>
                        </div>
                    </div>
                    <div class="row">
                        <h5 class="panel-title">
                            <i class="fa fa-chevron-circle-right"></i>Program Languages
                        </h5>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div id="gridLang"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Example Panel With Footer -->
        </div>
    </div>
</div>
<script>
    var $grid;
    let $gridLang;
    function documentReady() {
        setEvent();
        setGrid();
    };

    function setEvent(){
        $("#P_PRG_CD").change(function (e) {
            let id = $("#P_PRG_CD").val();
            $("#frmDetail").resetForm();
            getProgramDetail(id);
            getProgramAuthor(id);
            getProgramLang(id);
        });
    };

    function setGrid() {
        $grid = new Tabulator("#grid", {
            height:"250px",
            layout:"fitColumns",
            selectable:1,
            columns:[
                {
                    title:"No.",
                    field:"ID",
                    formatter:"rownum",
                    headerSort:false,
                    width: 50
                },
                {
                    title:"Authority Code",
                    field:"AUTH_CD",
                    width:200
                },
                {
                    title:"Authority Name",
                    field:"AUTH_NM",
                    width:200
                },
                {
                    title:"<spring:message code='BTN1_YN' />",
                    field:"BTN1_YN",
                    width: 80,
                    formatter:"tickCross",
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN2_YN' />",
                    field:"BTN2_YN",
                    width: 80,
                    formatter:"tickCross",
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN3_YN' />",
                    field:"BTN3_YN",
                    width: 80,
                    formatter:"tickCross",
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN4_YN' />",
                    field:"BTN4_YN",
                    width: 80,
                    formatter:"tickCross",
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN5_YN' />",
                    field:"BTN5_YN",
                    width: 80,
                    formatter:"tickCross",
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN6_YN' />",
                    field:"BTN6_YN",
                    width: 80,
                    formatter:"tickCross",
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN7_YN' />",
                    field:"BTN7_YN",
                    width: 80,
                    formatter:"tickCross",
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN8_YN' />",
                    field:"BTN8_YN",
                    width: 80,
                    formatter:"tickCross",
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN9_YN' />",
                    field:"BTN9_YN",
                    width: 80,
                    formatter:"tickCross",
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN10_YN' />",
                    field:"BTN10_YN",
                    width: 80,
                    formatter:"tickCross",
                    editor: true,
                }
            ]
        });
        $gridLang = new Tabulator("#gridLang", {
            height:"250px",
            layout:"fitColumns",
            selectable:1,
            columns:[
                {
                    title:"No.",
                    field:"ID",
                    formatter:"rownum",
                    headerSort:false,
                    width: 50
                },
                {
                    title:"<spring:message code='PRG_NM' />",
                    field:"PRG_NM",
                    width:200,
                    editor: true,
                },
                {
                    title:"<spring:message code='LANG_NM' />",
                    field:"LANG_NM",
                    width:200
                },
                {
                    title:"<spring:message code='BTN1_NM' />",
                    field:"BTN1_NM",
                    width: 120,
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN2_NM' />",
                    field:"BTN2_NM",
                    width: 120,
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN3_NM' />",
                    field:"BTN3_NM",
                    width: 120,
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN4_NM' />",
                    field:"BTN4_NM",
                    width: 120,
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN5_NM' />",
                    field:"BTN5_NM",
                    width: 120,
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN6_NM' />",
                    field:"BTN6_NM",
                    width: 120,
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN7_NM' />",
                    field:"BTN7_NM",
                    width: 120,
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN8_NM' />",
                    field:"BTN8_NM",
                    width: 120,
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN9_NM' />",
                    field:"BTN9_NM",
                    width: 120,
                    editor: true,
                },
                {
                    title:"<spring:message code='BTN10_NM' />",
                    field:"BTN10_NM",
                    width: 120,
                    editor: true,
                }
            ]
        });
    }
    function getProgramDetail(id) {
        var input = {
            id : "prg",
            type : "SQL_MULTI",
            params : {
                function:"AuthorityService.getProgramByCode",
                data: {PRG_CD: id}
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }
    function getProgramLang(id) {
        var input = {
            id : "lang",
            type : "SQL_MULTI",
            params : {
                function:"AuthorityService.getProgramLangByCode",
                data: {PRG_CD: id}
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }
    function getProgramAuthor(id) {
        var input = {
            id : "prg_auth",
            type : "SQL_MULTI",
            params : {
                function:"AuthorityService.getProgramAuthByCode",
                data: {PRG_CD: id}
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }
    function button1OnClick(){
        $("#frmDetail").resetForm();
        $("#MENU_YN").val("0");
        $("#btnAdd").prop("disabled",true);
        $("#btnDel").prop("disabled",true);
    }
    function button2OnClick(){
        let data = $("#frmDetail").serializeObject();
        if($("#P_PRG_CD").val()) {
            updateProgram(data);
            updateRole();
            return;
        }
        saveProgram(data);
    }
    function saveProgram(data){
        var input = {
            id : "save",
            type : "SQL_UPDATE",
            params : {
                function: "AuthoritySettingService.createPopupProgram",
                data: data
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }
    function updateProgram(data){
        var input = {
            id : "update",
            type : "SQL_UPDATE",
            params : {
                function: "AuthoritySettingService.updateProgram",
                data: data
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }
    function updateRole(){
        let data = $grid.getUpdateData();
        if(data.length == 0){
            return;
        }
        let input = {
            id : "role",
            type : "SQL_UPDATE",
            params : {
                function: "AuthoritySettingService.updateProgramAuthority",
                data: data
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }
    function tranCallBack(id, data, errorCode, errorMessage) {
        if(id == "prg" && data != null) {
            $("#frmDetail").populateToForm(data[0]);

            $("#btnAdd").prop("disabled",false);
            $("#btnDel").prop("disabled",false);
        }
        if(id == "prg_auth") {
            $grid.replaceData(data);
            return;
        }
        if(id == "search") {
            $grid.replaceData(data);
            return;
        }
    }
    function btnAddRoleClick(){
        var newItem = {
            AUTH_CD : '',
            AUTH_NM : '',
            USER_ID : '',
            USER_NM : '',
            USE_YN : '1',
            _rowStatus : 'I'
        };
        $grid.addData(newItem, true);
    }
    function btnDelRoleClick(){
        var row = $grid.getSelectedRows();

        if (row.length > 0) {
            var data = row[0].getData();

            if (data._rowStatus == 'I') {
                row[0].delete();
            }
        }
    }

</script>