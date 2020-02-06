<%--
  Created by Hong Nguyen
  Date: 2/5/2020
  Jasper report sample
--%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fo" uri="/WEB-INF/resources/tag/custom-tag.tld"%>
<div class="page-content container-fluid">
    <div class="row">
        <table style="width: 100%">
            <tr>
                <th>Simple jasper report</th>
                <td>
                <select class="form-control" id="cboReport">
                    <option value="Sample1.jrxml">Sample1</option>
                </select>
                </td>
                <td>
                    <button type="button" onclick="openPdfReport()">Open</button>
                </td>
            </tr>
        </table>
    </div>
</div>
<script>
    function documentReady() {

    }
    function openPdfReport() {
        fn_openPdfReport({
            name: "Sample1.jrxml",
            data: {"PRG_CD":"000002"},
            function: "MenuSettingService.getProgramList"
        })
    }
</script>
