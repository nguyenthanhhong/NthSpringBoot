<%--
  Created by Hong Nguyen
  Date: 2/3/2020
  Sample for custom component
--%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fo" uri="/WEB-INF/resources/tag/custom-tag.tld"%>
<div class="page-content container-fluid">
    <div class="row">
        <table style="width: 100%">
            <tr>
                <th><p>Add taglib</p></th>
                <td colspan="3">
                    <p id="an-id" style="color: red">This is not HTML!</p>
                </td>
            </tr>
            <tr>
                <th>Custom Tag Combobox</th>
                <td>
                    <fo:select name="cboRT" sqlId="getCommonCodeList" params="ROUND_TYPE" selectDefaultName="Select" selectedValue="02" cssClass="form-control"/>
                </td>
                <th>Custom Code List Tag - Select</th>
                <td>
                    <fo:codeList outType="select" cmCd="DATABASE" name="cboDb" selectDefaultName="Select" cssClass="form-control"/>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <textarea rows="2" style="width: 100%">
<ct:select name="cboRT" sqlId="getCommonCodeList" params="ROUND_TYPE" selectDefaultName="Select" selectedValue="02" cssClass="form-control"/>
                    </textarea>
                    &nbsp;
                </td>
                <td colspan="2">
                    <textarea rows="2" style="width: 100%">
<ct:codeList outType="select" cmCd="DATABASE" name="cboDb" selectDefaultName="Select" cssClass="form-control"/>
                    </textarea>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <th>Custom Code List Tag - Check box</th>
                <td>
                    <fo:codeList outType="checkbox" cmCd="DATABASE" name="ckDb" cssClass="chkArea" selectedValue="02"/>
                </td>
                <th>Custom Code List Tag - Radio box</th>
                <td>
                    <fo:codeList outType="radio" cmCd="DATABASE" name="rdDB" cssClass="chkArea" selectedValue="01"/>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <textarea rows="2" style="width: 100%">
<ct:codeList outType="checkbox" cmCd="DATABASE" name="ckDb" cssClass="chkArea" selectedValue="02"/>
                    </textarea>
                    &nbsp;
                </td>
                <td colspan="2">
                    <textarea rows="2" style="width: 100%">
<ct:codeList outType="radio" cmCd="DATABASE" name="rdDB" cssClass="chkArea" selectedValue="01"/>
                    </textarea>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <th>Multi check Combobox</th>
                <td>
                    <select class="custom-select" id="multiCombo" multiple="multiple">
                        <option value="cheese">Cheese</option>
                        <option value="tomatoes">Tomatoes</option>
                        <option value="mozzarella">Mozzarella</option>
                        <option value="mushrooms">Mushrooms</option>
                        <option value="pepperoni">Pepperoni</option>
                        <option value="onions">Onions</option>
                        <option value="bacon">Bacon</option>
                        <option value="potatoes">Potatoes</option>
                    </select>
                </td>
            </tr>
        </table>
    </div>
</div>
<script>
    function documentReady() {
        let txt = "<_%@taglib prefix='ct' uri='/WEB-INF/resources/tag/custom-tag.tld'%>".replace("_","");
        $("#an-id").text(txt);
        fn_setLocaleMask();
        /*$('#multiCombo').multiselect({
            enableClickableOptGroups: true,
            enableCollapsibleOptGroups: true,
            enableFiltering: true,
            includeSelectAllOption: true
        });*/
    }
</script>