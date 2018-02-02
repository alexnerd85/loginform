<%-- 
    Document   : error
    Created on : 02.02.2018, 10:09:56
    Author     : Aleksey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/lib/Semantic-UI-CSS-master/semantic.css"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/Semantic-UI-CSS-master/semantic.js"></script>
        <title>Ошибка</title>
    </head>
    <body>

            <h2 class="ui header">
                <i class="settings icon"></i>
                <div class="content">
                    Системная ошибка
                    <div class="sub header">Информация об ошибке: ${errMsg}</div>
                </div>
            </h2>


    </body>
</html>
