<%-- 
    Document   : index
    Created on : 30.01.2018, 22:09:19
    Author     : Aleksey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Главная таблица</title>
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/lib/Semantic-UI-CSS-master/semantic.css"/>
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/lib/font-awesome-4.7.0/css/font-awesome.min.css">
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/Semantic-UI-CSS-master/semantic.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tablesort.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('table').tablesort();
            });
        </script>
    </head>
    <body>
        <div class="ui container">
            <div class="ui basic segment">
                <table class="ui sortable celled table">
                    <thead>
                        <tr>
                            <th>Логин</th>
                            <th>Пароль</th>
                            <th>Баланс</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.username}</td>
                                <td>${user.password}</td>
                                <td>${user.wage}</td>
                            </tr>
                        </c:forEach>
                    <tfoot>
                        <tr>
                            <th colspan="6">Количество пользователей: ${users.size()}</th>
                        </tr>
                    </tfoot>
                </table>
                        (<a class="item" href="<c:url value="/logout"/>">Выход</a>)
                </body>
                </html>
