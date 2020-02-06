<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="fo" uri="/WEB-INF/resources/tag/custom-tag.tld"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value="/" var="rootUrl" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html>
<head>
    <title><tiles:getAsString name="title" /></title>

    <%@ include file="../jsp/main/constants.jspf"%>
    <link rel="stylesheet" type="text/css" href="../../webjars/bootstrap/4.1.3/css/bootstrap.min.css" />
    <%--<link rel="stylesheet" type="text/css" href="../../plugin/jquery-ui-1.12.1/jquery-ui.css">--%>
    <link rel="stylesheet" type="text/css" href="../../plugin/fontawesome-4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../../plugin/fancytree-2.33.0/dist/skin-awesome/ui.fancytree.min.css" />
    <link rel="stylesheet" type="text/css" href="../../plugin/tabulator-4.5.2/dist/css/tabulator.css" />
    <link rel="stylesheet" type="text/css" href="../../plugin/bootstrap-multiselect-0.9.15/dist/css/bootstrap-multiselect.css">
    <link rel="stylesheet" type="text/css" href="../../plugin/bootstrap-datepicker-1.9.0/css/bootstrap-datepicker.min.css" />
    <link rel="stylesheet" type="text/css" href="../../plugin/Chart.js-2.9.3/Chart.css">

    <link rel="stylesheet" type="text/css" href="../../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap-extend.css" />

    <script type="text/javascript" src="../../webjars/jquery/3.0.0/jquery.min.js"></script>
    <script type="text/javascript" src="../../webjars/bootstrap/4.1.3/js/bootstrap.bundle.js"></script>
	<script type="text/javascript" src="../../plugin/blockui-2.70/jquery.blockUI.js"></script>
	<script type="text/javascript" src="../../plugin/jquery-ui-1.12.1/jquery-ui.js"></script>

    <script type="text/javascript" src="../../plugin/bootstrap-datepicker-1.9.0/js/bootstrap-datepicker.min.js"></script>
    <%@ include file="../jsp/main/bootstrap-datepicker.local.jspf"%>
    <script type="text/javascript" src="../../plugin/Inputmask-5.0.3/dist/jquery.inputmask.js"></script>
    <script type="text/javascript" src="../../plugin/moment-2.24.0/moment.js"></script>

	<script type="text/javascript" src="../../plugin/fancytree-2.33.0/dist/jquery.fancytree-all-deps.min.js"></script>
    <script type="text/javascript" src="../../plugin/fancytree-2.33.0/dist/modules/jquery.fancytree.dnd.js"></script>
	<script type="text/javascript" src="../../plugin/tabulator-4.5.2/dist/js/tabulator.js"></script>
    <script type="text/javascript" src="../../plugin/bootstrap-multiselect-0.9.15/dist/js/bootstrap-multiselect.js"></script>
    <script type="text/javascript" src="../../plugin/Chart.js-2.9.3/Chart.js"></script>

    <script type="text/javascript" src="../../js/string-util.js"></script>
    <script type="text/javascript" src="../../js/ajax-request.js"></script>
    <script type="text/javascript" src="../../js/common_message.js"></script>
    <script type="text/javascript" src="../../js/form-util.js"></script>
    <script type="text/javascript" src="../../js/locale-util.js"></script>
    <script type="text/javascript" src="../../js/tabulator-util.js"></script>
    <script type="text/javascript" src="../../js/tree-util.js"></script>
</head>
<body style="height: calc(100vh - (34px)) !important;">
    <div class="container-fluid padding-0">
        <tiles:insertAttribute name="header" />
    </div>
    <div class="container-fluid padding-0 frame-content">
        <tiles:insertAttribute name="body" />
    </div>
    <div class="container-fluid padding-0 frame-footer">
        <tiles:insertAttribute name="footer" />
    </div>
</body>
<script>
    window.onload = function() {
        documentReady();
    };
</script>
</html>