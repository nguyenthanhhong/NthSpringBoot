<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<title><tiles:getAsString name="title" /></title>
</head>
    <link rel="stylesheet" type="text/css" href="../../css/style.css" />
<body>
    <div>
        <tiles:insertAttribute name="body" />
    </div>
</body>
</html>