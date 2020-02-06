<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value="/" var="rootUrl" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ERP Standard Website</title>
    <link rel="stylesheet" type="text/css" href="css/nav_menu.css" />
    <link rel="stylesheet" type="text/css" href="webjars/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="plugin/fontawesome-4.7.0/css/font-awesome.min.css" />

    <script type="text/javascript" src="webjars/jquery/3.0.0/jquery.min.js"></script>
	<script type="text/javascript" src="webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="plugin/blockui-2.70/jquery.blockUI.js"></script>

	<script type="text/javascript" src="plugin/jquery-ui-1.12.1/jquery-ui.js"></script>
	<script type="text/javascript" src="plugin/fancytree-2.33.0/dist/jquery.fancytree-all-deps.min.js"></script>
    <link rel="stylesheet" type="text/css" href="plugin/fancytree-2.33.0/dist/skin-win8/ui.fancytree.min.css" />
</head>
<body id="mainPageBody" style="margin: 0px 0pt 0pt; background-position: 0pt 0pt;">
    <header>
        <nav>
            <div class="menu-container">
                <div class="menu-button-area">
                    <ul id="nav-menu" class="topmenu">
                        <c:forEach items="${ds_menuList}" var="menu" varStatus="loop">
                            <c:choose>
                                <c:when test="${menu.PROG_LVL == 1 && (menu.PRG_URL==null || menu.PRG_URL=='')}">
                                  <li class="topmenu"><a href="#">${menu.PRG_NM}</a>
                                    <ul>
                                </c:when>
                                <c:when test="${menu.PRG_URL==null || menu.PRG_URL==''}">
                                  <li class="submenu"><a href="#"><span>${menu.PRG_NM}</span></a>
                                    <ul>
                                </c:when>
                                <c:otherwise>
                                  <li class="submenu"><a href="#"
                                      onclick="fn_open_frame('${menu.PRG_URL}','${menu.PRG_CD}','${menu.PRG_NM}');">${menu.PRG_NM}</a></li>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${!loop.last && menu.PROG_LVL > ds_menuList[loop.index+1].PROG_LVL}">
                                <c:forEach var="i" begin="${ds_menuList[loop.index+1].PROG_LVL}" end="${menu.PROG_LVL - 1}">
                                    </ul>
                                    </li>
                                </c:forEach>
                            </c:if>
                            <c:if test="${loop.last}">
                                <c:forEach var="i" begin="2" end="${menu.PROG_LVL}">
                                    </ul>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                        <li class="topmenu menu-search"><a href="#" ><i class="fa fa-search"></i>&nbsp;</a></li>
                    </ul>
                    <!-- Search -->
                    <div class="menu-search-container">
                        <div class="menu-search-input">
                            <form action="">
                                <a href="#">
                                    <i class="fa fa-search" aria-hidden="true"></i>
                                </a>
                                <input class="menu-search-input" type="text" aria-label="Search..." placeholder="Search..." autocorrect="off" autocapitalize="off" autocomplete="off" spellcheck="false">
                            </form>
                        </div>
                        <a class="menu-search-close" href="#">
                            <i class="fa fa-close" aria-hidden="true"></i>
                        </a>
                        <div class="search-sub-menu">
                            <h3>Quick Links</h3>
                            <ul>
                                <li><a href="#">Find a store</a></li>
                                <li><a href="#">Accessories</a></li>
                                <li><a href="#">iPod</a></li>
                                <li><a href="#">iOS</a></li>
                                <li><a href="#">Gift Cards</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="menu-info-area">
                    <div><a href="#" ><i class="fa fa-user" aria-hidden="true"></i></a></div>
                    <div><a href="#" ><i class="fa fa-globe" aria-hidden="true"></i></a></div>
                    <div><a href="#" ><i class="fa fa-sign-out" aria-hidden="true"></i></a></div>
                </div>
            </div>
        </nav>
    </header>
    <div class="main-container nav-tabs-horizontal nav-tabs-inverse">
        <ul id="tab_list" class="nav nav-tabs nav-tabs-solid">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#home">Home</a>
            </li>
        </ul>

        <div id="tab_content" class="tab-content">
            <div id="home" class="tab-pane active" role="tabpanel">
                <div class="embed-responsive">
                    <iframe class="embed-responsive-item" name="frame1" src="http://localhost:8080/mysql/home" allowfullscreen></iframe>
                </div>
            </div>
        </div>
    </div>

<script>
    let MENU_ARR = [];
    $( document ).ready(function() {
        // test plugin
        $("#datepicker").datepicker();
        $("#tree").fancytree({
            checkbox: true,
            source: [
                {title: "Node 1"},
                {title: "Node 2", key: "id2"},
                {title: "Folder 3", folder: true, children: [
                    {title: "Node 3.1"},
                    {title: "Node 3.2"}
                ]},
                {title: "Folder 2", folder: true}
            ],
            activate: function(event, data){
                $("#status").text("Activate: " + data.node);
            }
        });
        // test plugin
        console.log("documentReady");
        var $searchView = $('.menu-search-container');
        var $menu = $('li.topmenu');

        $('li.menu-search a, .menu-search-close').on('click', function(e) {
            $searchView.toggleClass('active');

            setTimeout(function(){
                $searchView.children().find('input').focus();
            }, 1100);

            $menu.removeClass('is-closed');
            $menu.toggleClass('d-none');

            e.preventDefault();
        });

        $('.menu-search-close').on('click', function(e) {
            $menu.toggleClass('is-closed');
            e.preventDefault();
        });
    })

    function fn_open_frame(url, menu_code, menu_name){
        // check exit menu tab
        if(MENU_ARR.find(p => p.PRG_CD == menu_code)) {
            $("#tab_list > li > a.active").removeClass("active show");
            $("#tab_content > div.tab-pane.active").removeClass("active show");
            $('#tab_list > li[name=M' + menu_code + '] > a').addClass("active show");
            $('#tab_content > div[id=M' + menu_code + ']').addClass("active show");
            return;
        } else {
            // add to tab tab list
            var cur_prog = {
                PRG_CD: menu_code,
                PRG_NM: menu_name,
                URL: url
            };
            MENU_ARR.push(cur_prog);
        }
        // open new menu tab
        $("#tab_list > li > a.active").removeClass("active show");
        $("#tab_list").append(
            '<li class="nav-item" name=M' + menu_code + '>' +
            '    <a class="nav-link active show" data-toggle="tab" href="#M' + menu_code + '" role="tab">' +
            '        <span class="close close-tab" data-close="tab" aria-label="Close"><strong title="true">&#215;</strong></span>' + menu_name +
            '    </a>' +
            '</li>'
        );

        $("#tab_content > div.tab-pane.active").removeClass("active show");
        $("#tab_content").append(
            '<div id="M' + menu_code + '" class="tab-pane active show" role="tabpanel">' +
            '    <div class="embed-responsive">' +
            '        <iframe class="embed-responsive-item" name="frame1" src="' + url + '" allowfullscreen></iframe>' +
            '    </div>' +
            '</div>'
        );
        // register close tab button
        fn_close_tab_click();
    }

    function fn_close_tab_click(){
        $(".close-tab").click(function() {
            var tabContentId = $(this)
              .parent()
              .attr("href");
            $(this)
              .parent()
              .parent()
              .remove();
            $("#tab_list a:last").tab("show");
            $(tabContentId).remove();

            MENU_ARR = MENU_ARR.filter(p => p.PRG_CD != tabContentId.replace("#M",""));
        });
    }
</script>
</body>
</html>