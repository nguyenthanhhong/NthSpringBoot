<%--
  Created by Hong Nguyen
  Date: 1/24/2020
  Sample for bootstrap datepicker
--%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="page-content container-fluid">
    <div class="row">
        <div class="col-lg-8">
            <table>
                <tr>
                    <th><span class="star"></span><spring:message code="Set Value To Datepicker" /></th>
                    <td>
                        <input type="text" class="form-control" id="txtInDate" placeholder="YYYYMMDD"/>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" onclick="setDateValue('txtInDate')">SetValue</button>
                    </td>
                </tr>
                <tr>
                    <th><span class="star"></span><spring:message code="Date time picker" /></th>
                    <td>
                        <input type="text" class="form-control" id="txtDate" txtformat="date"/>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" onclick="getDateValue('txtDate','txtDateVal')">GetValue</button>
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txtDateVal" readonly/>
                    </td>
                </tr>
                <tr>
                    <th><span class="star"></span><spring:message code="Day and Month picker" /></th>
                    <td>
                        <input type="text" class="form-control" id="txtDayMonth" txtformat="day"/>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" onclick="getDateValue('txtDayMonth','txtDayVal')">GetValue</button>
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txtDayVal" readonly/>
                    </td>
                </tr>
                <tr>
                    <th><span class="star"></span><spring:message code="Month and Year picker" /></th>
                    <td>
                        <input type="text" class="form-control" name="txtMonthYear" id="txtMonthYear" txtformat="month"/>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" onclick="getDateValue('txtMonthYear', 'txtMonthVal')">GetValue</button>
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txtMonthVal" readonly/>
                    </td>
                </tr>
                <tr>
                    <th><span class="star"></span><spring:message code="Year picker" /></th>
                    <td>
                        <input type="text" class="form-control" id="txtYear" txtformat="year"/>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" onclick="getDateValue('txtYear', 'txtYearVal')">GetValue</button>
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txtYearVal" readonly/>
                    </td>
                </tr>
            </table>
        </div>

        <div class="col-lg-4">
            <table>
                <tr>
                    <th><span class="star"></span><spring:message code="Time validate 1" /></th>
                    <td>
                        <input type="text" class="form-control" name="txtTime1" id="txtTime1" txtformat="time"/>
                    </td>
                <tr>
                </tr>
                    <th><span class="star"></span><spring:message code="Time validate 2" /></th>
                    <td>
                        <input type="text" class="form-control" name="txtTime2" id="txtTime2" txtformat="hh:MM TT"/>
                    </td>
                <tr>
                </tr>
                    <th><span class="star"></span><spring:message code="Time validate 3" /></th>
                    <td>
                        <input type="text" class="form-control" name="txtTime3" id="txtTime3" txtformat="HH:MM:ss"/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<script>
    function documentReady() {
        fn_setLocaleMask();
    }
    function getDateValue(from, to) {
        let value = $("#" + from).val();
        if(!value) {
            fn_showMessage("Please input datetime value!!!");
            return;
        }
        $("#" + to).val($("#" + from).val());
    }
    function setDateValue(from) {
        let value = $("#" + from).val();
        if(!value) {
            fn_showMessage("Please input correct value!!!");
            return;
        }
        $("#txtDate").val(value);
        $("#txtDayMonth").val(value);
        $("#txtMonthYear").val(value);
        $("#txtYear").val(value.substr(0,4));
    }
</script>
