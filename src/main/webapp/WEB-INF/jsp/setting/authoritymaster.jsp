<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="page-content container-fluid">
    <div class="panel">
        <form name="frmSearch" id="frmSearch">
            <table>
                <tr>
                    <th><span class="star"></span><spring:message code="authority code" /></th>
                    <td>
                        <input type="text" class="form-control" name="S_AUTH_NM" id="S_AUTH_NM" />
                    </td>
                    <th><span class="star"></span><spring:message code="authority name" /></th>
                    <td>
                        <input type="text" class="form-control" name="S_USER_NM" id="S_USER_NM" />
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
                        <i class="fa fa-chevron-circle-right"></i>Authority Group Code
                    </h5>
                    <div class="panel-actions">
                        <button type="button" class="btn btn-icon btn-danger btn-sm" onclick="btnAddGroupClick()"><i class="icon fa fa-plus" aria-hidden="true"></i></button>
                        <button type="button" class="btn btn-icon btn-danger btn-sm" onclick="btnDelGroupClick()"><i class="icon fa fa-minus" aria-hidden="true"></i></button>
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
                        <i class="fa fa-chevron-circle-right"></i>User List
                    </h5>
                    <div class="panel-actions">
                        <button type="button" class="btn btn-icon btn-danger btn-sm" onclick="btnAddUserClick()"><i class="icon fa fa-plus" aria-hidden="true"></i></button>
                        <button type="button" class="btn btn-icon btn-danger btn-sm" onclick="btnDelUserClick()"><i class="icon fa fa-minus" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="panel-body">
                    <form name="frmInfo" id="frmInfo">
                        <table>
                            <tr>
                                <th><span class="star"></span><spring:message code="authority code" /></th>
                                <td>
                                    <input type="text" class="form-control" name="AUTH_CD" placeholder="Authority code...">
                                </td>
                            </tr>
                            <tr>
                                <th><span class="star"></span><spring:message code="authority name" /></th>
                                <td>
                                    <input type="text" class="form-control" name="AUTH_NM" placeholder="Authority code name...">
                                </td>
                            </tr>
                        </table>
                    </form>
                    <div class="row">
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
    function documentReady() {
        setEvent();
        $grid = new Tabulator("#grid", {
            height:"372px",
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
                },
                {
                    title:"Note",
                    field:"NOTE",
                }
            ],
            rowSelected:function(row){
                let data = row._row.data;
                $("#frmInfo").populateToForm(data);
                searchdetail(data.AUTH_CD);
            },
            /*rowDeselected:function(row){
                $("#frmInfo").resetForm();
                $grid_detail.replaceData();
            },*/
        });

        $grid_detail = new Tabulator("#grid_detail", {
            height:"311px",
            layout:"fitColumns",
            columns:[
                {
                    title: 'No.',
                    field: 'ID',
                    formatter:"rownum",
                    headerSort:false,
                    width: 50
                }, {
                    title: 'User Code',
                    field: 'USER_ID',
                    editor: true,
                    editable: editCheck
                }, {
                    title: 'User Name',
                    field: 'USER_NM',
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
                function:"AuthorityService.getAuthList",
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
                function: "AuthorityService.saveAuthGroup",
                data: $grid_detail.getUpdateData()
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }
    function searchdetail(id){
        var input = {
            id : "search_detail",
            type : "SQL_MULTI",
            params : {
                function: "AuthorityService.getUserByAuthCode",
                data: {AUTH_CD: id}
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
    function btnAddUserClick(){
        var newItem = {
            AUTH_CD : $('#frmInfo input[name=AUTH_CD]').val(),
            AUTH_NM : $('#frmInfo input[name=AUTH_NM]').val(),
            USER_ID : '',
            USER_NM : '',
            USE_YN : '1',
            _rowStatus : 'I'
        };
        $grid_detail.addData(newItem, true);
    }
    function btnDelUserClick(){
        var row = $grid_detail.getSelectedRows();

        if (row.length > 0) {
            var data = row[0].getData();

            if (data._rowStatus == 'I') {
                row[0].delete();
            }
        }
    }
    function btnAddGroupClick(){
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
    function btnDelGroupClick(){
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
    function setEvent(){
        $("#frmInfo").find("input, select").change(function (e) {
            var row = $grid.getSelectedRows();

            if (row.length > 0) {
                /*update group code grid */
                var eachKey = $(this).attr("name");
                var data = row[0].getData();

                if ($(this).attr('type') && $(this).attr('type').toUpperCase() == 'CHECKBOX') {
                    data[eachKey] = ($(this).is(':checked') ? '1' : '0');
                } else {
                    data[eachKey] = $(this).val();
                }

                if (data._rowStatus != 'I') {
                    data._rowStatus = 'U';
                }
                row[0].update(data);
                /*update group code detail grid */
                let detaiData = $grid_detail.getData();
                $.each(detaiData, function() {
                    this[eachKey] = data[eachKey];
                    if (this._rowStatus != 'I') {
                        this._rowStatus = "U";
                    }
                });
                $grid_detail.replaceData(detaiData);
            }
        });
    };
</script>