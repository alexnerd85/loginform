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
        <title>Ошибка</title>
    </head>
    <body>
        <h1>Ошибка</h1>
        <c:if test="${not empty errMsg}">
            <h2>Информация об ошибке:</h2>
            ${errMsg}
        </c:if>
        <br><br>
    </body>
</html>
