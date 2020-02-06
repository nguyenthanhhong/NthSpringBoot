<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class = "content-center">
    <c:if test="${CURR_PAGE.BTN1_NM != ''}">
        <button type="button" class="btn btn-primary mg-5" onclick="javascript:button1OnClick(this)">${CURR_PAGE.BTN1_NM}</button>
    </c:if>
    <c:if test="${CURR_PAGE.BTN2_NM != ''}">
        <button type="button" class="btn btn-primary mg-5" onclick="javascript:button2OnClick(this)">${CURR_PAGE.BTN2_NM}</button>
    </c:if>
    <c:if test="${CURR_PAGE.BTN3_NM != ''}">
        <button type="button" class="btn btn-primary mg-5" onclick="javascript:button3OnClick(this)">${CURR_PAGE.BTN3_NM}</button>
    </c:if>
    <c:if test="${CURR_PAGE.BTN4_NM != ''}">
        <button type="button" class="btn btn-primary mg-5" onclick="javascript:button4OnClick(this)">${CURR_PAGE.BTN4_NM}</button>
    </c:if>
    <c:if test="${CURR_PAGE.BTN5_NM != ''}">
        <button type="button" class="btn btn-primary mg-5" onclick="javascript:button5OnClick(this)">${CURR_PAGE.BTN5_NM}</button>
    </c:if>
    <c:if test="${CURR_PAGE.BTN6_NM != ''}">
        <button type="button" class="btn btn-primary mg-5" onclick="javascript:button6OnClick(this)">${CURR_PAGE.BTN6_NM}</button>
    </c:if>
    <c:if test="${CURR_PAGE.BTN7_NM != ''}">
        <button type="button" class="btn btn-primary mg-5" onclick="javascript:button7OnClick(this)">${CURR_PAGE.BTN7_NM}</button>
    </c:if>
    <c:if test="${CURR_PAGE.BTN8_NM != ''}">
        <button type="button" class="btn btn-primary mg-5" onclick="javascript:button8OnClick(this)">${CURR_PAGE.BTN8_NM}</button>
    </c:if>
    <c:if test="${CURR_PAGE.BTN9_NM != ''}">
        <button type="button" class="btn btn-primary mg-5" onclick="javascript:button9OnClick(this)">${CURR_PAGE.BTN9_NM}</button>
    </c:if>
    <c:if test="${CURR_PAGE.BTN10_NM != ''}">
        <button type="button" class="btn btn-primary mg-5" onclick="javascript:button10OnClick(this)">${CURR_PAGE.BTN10_NM}</button>
    </c:if>
</div>