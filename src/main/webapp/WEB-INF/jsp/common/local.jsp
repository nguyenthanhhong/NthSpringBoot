<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="fo" uri="/WEB-INF/resources/tag/custom-tag.tld"%>
<div class="page-content container-fluid">
    <div class="row">
        <div class="col-lg-6">
            <!-- Example Panel With Heading -->
            <div class="panel">
                <div class="panel-heading pdt-8">
                    <h5 class="panel-title">
                        <i class="fa fa-chevron-circle-right"></i>Location
                    </h5>
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
                        <i class="fa fa-chevron-circle-right"></i>Location Setup
                    </h5>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <form name="frmInfo" id="frmInfo">
                            <table>
                                <tr>
                                    <th><span class="star"></span><spring:message code="Language" /></th>
                                    <td>
                                        <input type="hidden" class="form-control" name="ID" id="ID"/>
                                        <input type="hidden" class="form-control" name="USE_YN" id="USE_YN"/>
                                        <fo:select id="LANG_CD" name="LANG_CD" sqlId="getLangList" selectDefaultName="Select" required="true" />
                                    </td>
                                    <th><span class="star"></span><spring:message code="Currency" /></th>
                                    <td>
                                        <fo:codeList outType="select" cmCd="CURRENCY" id="CURR_CD" name="CURR_CD" selectDefaultName="Select" required="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <th><span class="star"></span><spring:message code="Currency Location" /></th>
                                    <td>
                                        <fo:codeList outType="select" cmCd="CURR_PLACE" name="CURR_PLACE" selectDefaultName="Select" required="true"/>
                                    </td>
                                    <th><span class="star"></span><spring:message code="Currency Format" /></th>
                                    <td>
                                        <fo:codeList outType="select" cmCd="NUM_FORMAT" name="CURR_FORMAT" selectDefaultName="Select" required="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <th><span class="star"></span><spring:message code="Date Format" /></th>
                                    <td>
                                        <fo:codeList outType="select" cmCd="DATE_FORMAT" name="DATE_FORMAT" selectDefaultName="Select" required="true" />
                                    </td>
                                    <th><span class="star"></span><spring:message code="Time Format" /></th>
                                    <td>
                                        <fo:codeList outType="select" cmCd="TIME_FORMAT" name="TIME_FORMAT" selectDefaultName="Select" required="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <th><span class="star"></span><spring:message code="Number Format" /></th>
                                    <td>
                                        <fo:codeList outType="select" cmCd="NUM_FORMAT" name="NUM_FORMAT" selectDefaultName="Select" required="true" />
                                    </td>
                                    <th><span class="star"></span><spring:message code="Round Method" /></th>
                                    <td>
                                        <fo:codeList outType="select" cmCd="ROUND_TYPE" name="ROUND_TYPE" selectDefaultName="Select" required="true" />
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
            <!-- End Example Panel With Footer -->
        </div>
    </div>
</div>
<script>
    var $grid;
    function documentReady() {
        //fn_setLocaleMask();
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
                    title:"<spring:message code='Applied' />",
                    field:"USE_YN",
                    formatter:"tickCross",
                    width:100
                },
                {
                    title:"<spring:message code='LANG_CD' />",
                    field:"LANG_CD",
                    width:150
                },
                {
                    title:"<spring:message code='CURR_CD' />",
                    field:"CURR_CD",
                    width:150
                },
                {
                    title:"<spring:message code='CURR_PLACE' />",
                    field:"CURR_PLACE",
                    width:150
                },
                {
                    title:"<spring:message code='CURR_FORMAT' />",
                    field:"CURR_FORMAT",
                    width:150
                },
                {
                    title:"<spring:message code='DATE_FORMAT' />",
                    field:"DATE_FORMAT",
                    width:150
                },
                {
                    title:"<spring:message code='TIME_FORMAT' />",
                    field:"TIME_FORMAT",
                    width:150
                },
                {
                    title:"<spring:message code='NUM_FORMAT' />",
                    field:"NUM_FORMAT",
                    width:150
                },
                {
                    title:"<spring:message code='ROUND_TYPE' />",
                    field:"ROUND_TYPE",
                    width:150
                }
            ],
            rowSelected:function(row){
                let data = row._row.data;
                $("#frmInfo").populateToForm(data);
            }
        });
        searchLocalList();
    };
    function searchLocalList(){
        var input = {
            id : "search",
            type : "SQL_MULTI",
            params : {
                function:"LocalService.getLocalData",
                data: "1=1"
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }
    function button1OnClick(){
        var newItem = {
            ID : $grid.getDataCount() + 1,
            USE_YN : '0',
            _rowStatus : 'I'
        };
        $grid.addData(newItem, true);
    }
    function button2OnClick(){
        var input = {
            id : "save",
            type : "SQL_UPDATE",
            params : {
                function: "LocalService.saveLocalSetting",
                data: $("#frmInfo").serializeObject()
            },
            callBack : tranCallBack,
            isLoad : true,
            isAsync: false
        };
        transaction(input);
    }
    function button3OnClick(){
        var input = {
            id : "apply",
            type : "SQL_UPDATE",
            params : {
                function: "LocalService.applyLocalSetting",
                data: {ID : $("#ID").val()}
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
        searchLocalList();
    }
</script>