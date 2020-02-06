<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value="/" var="rootUrl" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html>
<head>
    <title><tiles:getAsString name="title" /></title>
</head>
<%@ include file="../jsp/main/constants.jspf"%>
<link rel="stylesheet" type="text/css" href="../../webjars/bootstrap/4.1.3/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="../../plugin/fontawesome-4.7.0/css/font-awesome.min.css" />
<%--<link rel="stylesheet" type="text/css" href="../../plugin/jquery-ui-1.12.1/jquery-ui.css" />--%>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-modal/2.2.6/css/bootstrap-modal.css" />
<link rel="stylesheet" type="text/css" href="../../plugin/fancytree-2.33.0/dist/skin-win8/ui.fancytree.min.css" />
<link rel="stylesheet" type="text/css" href="../../plugin/bootstrap-multiselect-0.9.15/dist/css/bootstrap-multiselect.css">
<link rel="stylesheet" type="text/css" href="../../plugin/bootstrap-datepicker-1.9.0/css/bootstrap-datepicker.min.css" />

<link rel="stylesheet" type="text/css" href="../../css/style.css" />
<link rel="stylesheet" type="text/css" href="../../css/bootstrap-extend.css" />

<script type="text/javascript" src="../../webjars/jquery/3.0.0/jquery.min.js"></script>
<script type="text/javascript" src="../../webjars/bootstrap/4.1.3/js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="../../plugin/blockui-2.70/jquery.blockUI.js"></script>
<script type="text/javascript" src="../../plugin/jquery-ui-1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="../../plugin/fancytree-2.33.0/dist/jquery.fancytree-all-deps.min.js"></script>
<script type="text/javascript" src="../../plugin/bootstrap-multiselect-0.9.15/dist/js/bootstrap-multiselect.js"></script>

<script type="text/javascript" src="../../plugin/bootstrap-datepicker-1.9.0/js/bootstrap-datepicker.min.js"></script>
<%@ include file="../jsp/main/bootstrap-datepicker.local.jspf"%>
<script type="text/javascript" src="../../plugin/Inputmask-5.0.3/dist/jquery.inputmask.js"></script>
<script type="text/javascript" src="../../plugin/moment-2.24.0/moment.js"></script>

<script type="text/javascript" src="../../js/ajax-request.js"></script>
<script type="text/javascript" src="../../js/locale-util.js"></script>
<script type="text/javascript" src="../../js/string-util.js"></script>
<script type="text/javascript" src="../../js/common_message.js"></script>
<body style="height: calc(100vh - (34px)) !important;">
    <div class="container-fluid padding-0">
        <tiles:insertAttribute name="body" />
    </div>
</body>
<script>
    window.onload = function() {
        documentReady();
    };
</script>
</html>