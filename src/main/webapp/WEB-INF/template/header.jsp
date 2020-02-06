<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<ol class="breadcrumb breadcrumb-arrow">
    <c:forTokens items="${CURR_PAGE.MENU_LEVEL}" delims="," var="mySplit">
       <li class="breadcrumb-item">${mySplit}</li>
    </c:forTokens>
</ol>