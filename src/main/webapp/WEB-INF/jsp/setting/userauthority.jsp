<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="page-content container-fluid">
    <div class="panel">
        <form name="frmSearch" id="frmSearch">
            <table>
                <tr>
                    <th><span class="star"></span><spring:message code="user code" /></th>
                    <td>
                        <input type="text" class="form-control" name="S_P_CODE_NM" id="S_P_CODE_NM" />
                    </td>
                    <th><span class="star"></span><spring:message code="code" /></th>
                    <td>
                        <input type="text" class="form-control" name="S_CODE_NM" id="S_CODE_NM" />
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
        <div class="col-lg-12">
            <!-- Example Panel With Heading -->
            <div class="panel">
                <div class="panel-heading pdt-8">
                    <h5 class="panel-title">
                        <i class="fa fa-chevron-circle-right"></i>User Authority List
                    </h5>
                </div>
                <div class="panel-body">
                    <div id="grid"></div>
                </div>
            </div>
            <!-- End Example Panel With Heading -->
        </div>
    </div>
</div>
<script>
    var $grid;
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
                }, {
                    title:"<spring:message code='USER_ID' />",
                    field:"USER_ID",
                    width:100
                }, {
                    title:"<spring:message code='USER_NM' />",
                    field:"USER_NM",
                    width:200
                }, {
                    title:"<spring:message code='AUTH_CD' />",
                    field:"AUTH_CD",
                    width:200
                }, {
                    title:"<spring:message code='AUTH_NM' />",
                    field:"AUTH_NM",
                }, {
                    title: "<spring:message code='Use' />",
                    field: 'USE_YN',
                    formatter:"tickCross",
                    editor: true,
                }
            ],
            rowSelected:function(row){
                let data = row._row.data;
                $("#frmInfo").populateToForm(data);
            },
            /*rowDeselected:function(row){
                $("#frmInfo").resetForm();
                $grid_detail.replaceData();
            },*/
        });
    };
    function button1OnClick(){
        var input = {
            id : "search",
            type : "SQL_MULTI",
            params : {
                function:"UserSettingService.getUserAuthList",
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
                function: "UserSettingService.saveUserSetting",
                data: $("#frmInfo").serializeObject()
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
    }
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
            }
        });
    };
</script>