<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fo" uri="/WEB-INF/resources/tag/custom-tag.tld"%>
<div class="page-content container-fluid">
    <div class="panel">
        <form name="frmSearch" id="frmSearch">
            <table>
                <tr>
                    <th><span class="star"></span><spring:message code="message code" /></th>
                    <td>
                        <input type="text" class="form-control" name="S_P_MSG_NM" id="S_P_MSG_NM" />
                    </td>
                    <th><span class="star"></span><spring:message code="message name" /></th>
                    <td>
                        <input type="text" class="form-control" name="S_MSG_NM" id="S_MSG_NM" />
                    </td>
                    <th><span class="star"></span><spring:message code="use" /></th>
                    <td>
                        <div class="input-group">
                            <label class="chkArea"><input type="checkbox" name="S_USE_YN" value="1"><span></span><spring:message code="YES" /></label>
                            <label class="chkArea"><input type="checkbox" name="S_USE_YN" value="0"> <span></span><spring:message code="NO" /></label>
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div class="row">
        <div class="col-lg-6">
            <!-- Example Panel With Heading -->
            <div class="panel">
                <div class="panel-heading pdt-8">
                    <h5 class="panel-title">
                        <i class="fa fa-chevron-circle-right"></i>Message List
                    </h5>
                    <div class="panel-actions">
                        <button type="button" class="btn btn-icon btn-danger btn-sm" onclick="btnAddMessClick()"><i class="icon fa fa-plus" aria-hidden="true"></i></button>
                        <button type="button" class="btn btn-icon btn-danger btn-sm" onclick="btnDelMessClick()"><i class="icon fa fa-minus" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="panel-body">
                    <div id="grid"></div>
                </div>
            </div>
            <!-- End Example Panel With Heading -->
        </div>

        <div class="col-lg-6">
            <!-- Example Panel With Footer -->
            <div class="panel">
                <div class="panel-heading pdt-8">
                    <h5 class="panel-title">
                        <i class="fa fa-chevron-circle-right"></i>Languagues List
                    </h5>
                    <div class="panel-actions">
                        <button type="button" class="btn btn-icon btn-danger btn-sm" onclick="btnAddLangClick()"><i class="icon fa fa-plus" aria-hidden="true"></i></button>
                        <button type="button" class="btn btn-icon btn-danger btn-sm" onclick="btnDelLangClick()"><i class="icon fa fa-minus" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="panel-body"><div class="row">
                    <div class="col-md-12">
                        <div id="grid_detail"></div>
                    </div>
                </div>
                </div>
                <div class="panel-footer">Panel Footer</div>
            </div>
            <!-- End Example Panel With Footer -->
        </div>
    </div>
</div>
<script>
    var $grid;
    var $grid_detail;
    var langList = JSON.parse('<fo:codeList outType="list" cmCd="LANG"/>');
    function documentReady() {
        $grid = new Tabulator("#grid", {
            height:"370px",
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
                    title:"Message Code",
                    field:"MSG_CD",
                    editor: true,
                    editable: editCheck
                }
            ],
            rowSelected:function(row){
                let data = row._row.data;
                searchdetail(data.MSG_CD);
            }
        });

        $grid_detail = new Tabulator("#grid_detail", {
            height:"370px",
            layout:"fitColumns",
            columns:[
                {
                    title: 'No.',
                    field: 'ID',
                    formatter:"rownum",
                    headerSort:false,
                    width: 50
                }, {
                    title: 'Language',
                    field: 'LANG_CD',
                    editor: true,
                    editable: editCheck
                }, {
                    title: 'Message Code',
                    field: 'MSG_CD',
                    editor: false,
                }, {
                    title: 'Message Name',
                    field: 'MSG_NM',
                    editor: true,
                }, {
                    title: 'Use',
                    field: 'USE_YN',
                    formatter:"tickCross",
                    editor: true,
                }
            ],
            cellEdited:function(cell){
                var row = cell.getRow();
                if (row.getData()._rowStatus !== 'I') {
                    row.update({
                        "_rowStatus": "U"
                    });
                }
            },
        });
        button1OnClick();
    };
    function button1OnClick(){
        var input = {
            id : "search",
            type : "SQL_MULTI",
            params : {
                function:"MessageService.getMsgList",
                data: $("#frmSearch").serializeObject()
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }
    function button2OnClick(){
        var input = {
            id : "save",
            type : "SQL_UPDATE",
            params : {
                function: "MessageService.saveMsg",
                data: $grid_detail.getUpdateData()
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }
    function button3OnClick(){
        $.ajax({
            method: 'GET',
            url: '/main/reloadMsgSource',
            complete:function(jqXHR, textStatus) {
                fn_showMessage("Reload resource successfully");
            }
        });
    }
    function searchdetail(id){
        if(!id) {return;}
        var input = {
            id : "search_detail",
            type : "SQL_MULTI",
            params : {
                function: "MessageService.getLangByMsg",
                data: {MSG_CD: id}
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }
    function tranCallBack(id, data, errorCode, errorMessage) {
        if(id == "search") {
            $grid.replaceData(data);
            return;
        }
        if(id == "search_detail") {
            $grid_detail.replaceData(data);
        }
    }
    function btnAddLangClick(){
        var row = $grid.getSelectedData();
        if (row.length == 0) {
            return;
        }
        $(langList).each(function(index, element) {
            var newItem = {
                MSG_CD : row[0].MSG_CD,
                MSG_NM : row[0].MSG_NM,
                LANG_CD : element.code,
                LANG_NM : element.value,
                USE_YN : '1',
                _rowStatus : 'I'
            };
            $grid_detail.addData(newItem, true);
        });
    }
    function btnDelLangClick(){
        var row = $grid_detail.getSelectedRows();

        if (row.length > 0) {
            var data = row[0].getData();

            if (data._rowStatus == 'I') {
                row[0].delete();
            }
        }
    }
    function btnAddMessClick(){
        var newItem = {
            MSG_CD : '',
            MSG_NM : '',
            USE_YN : '1',
            _rowStatus : 'I'
        };
        $grid.addData(newItem, true);
    }
    function btnDelMessClick(){
        var row = $grid.getSelectedRows();

        if (row.length > 0) {
            var data = row[0].getData();

            if (data._rowStatus == 'I') {
                row[0].delete();
            }
        }
    }
    var editCheck = function (cell) {
        var data = cell.getRow().getData();
        return data._rowStatus == 'I';
    };
</script>