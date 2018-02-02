<%-- 
    Document   : login
    Created on : 31.01.2018, 9:48:24
    Author     : Aleksey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Вход на сайт</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/lib/Semantic-UI-CSS-master/semantic.css"/>
        <link type="text/css" rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/resources/lib/jquery-ui-1.12.1.custom/jquery-ui.css"/>
        <style>
            label, input { display:block; }
            input.text { margin-bottom:12px; width:95%; padding: .4em; }
            fieldset { padding:0; border:0; margin-top:25px; }
            h1 { font-size: 1.2em; margin: .6em 0; }
            div#users-contain { width: 350px; margin: 20px 0; }
            div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
            div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
            .ui-dialog .ui-state-error { padding: .3em; }
            .validateTips { border: 1px solid transparent; padding: 0.3em; }
        </style>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/Semantic-UI-CSS-master/semantic.js"></script>
        <script type="text/javascript">
            
            $(function () {
                var dialog, form,
                        login = $("#reglogin"),
                        password = $("#regpassword"),
                        wage = $("#regwage"),
                        allFields = $([]).add(login).add(password).add(wage),
                        tips = $(".validateTips");                      

                function updateTips(t) {
                    tips
                            .text(t)
                            .addClass("ui-state-highlight");
                    setTimeout(function () {
                        tips.removeClass("ui-state-highlight", 1500);
                    }, 500);
                }

                function checkLength(o, n, min, max) {
                    if (o.val().length > max || o.val().length < min) {
                        o.addClass("ui-state-error");
                        updateTips("Длина поля должна быть между " +
                                min + " и " + max + " символами.");
                        return false;
                    } else {
                        return true;
                    }
                }

                function checkRegexp(o, regexp, n) {
                    if (!(regexp.test(o.val()))) {
                        o.addClass("ui-state-error");
                        updateTips(n);
                        return false;
                    } else {
                        return true;
                    }
                }

                function checkLogin(o, n) {
                    var isUnique = false;
                    $.ajax({
                        url: "${pageContext.request.contextPath}/user/checklogin",
                        type: "GET",
                        data: {username: o.val()},
                        success: function (data) {
                            if ($.trim(data) === 'true') {
                                o.addClass("ui-state-error");
                                updateTips(n);
                            } else {
                                isUnique = true;
                            }
                        },
                        dataType: "text",
                        async: false
                    });
                    return isUnique;
                }

                function addUser() {
                    var valid = true;
                    allFields.removeClass("ui-state-error");

                    valid = valid && checkLength(login, "reglogin", 1, 254);
                    valid = valid && checkLength(password, "regpassword", 1, 254);
                    valid = valid && checkLength(wage, "regwage", 0, 16);
                    
                    valid = valid && checkRegexp(login, /^([a-zA-Z])([0-9a-zA-Z_])+$/, "Логин должен начинаться с латинской буквы и может состоять из латинских букв, цифр и нижнего подчеркивания");
                    valid = valid && checkLogin(login, "Данный логин уже зарегестрирован, выберите другой");
                    valid = valid && checkRegexp(password, /^([0-9a-zA-Z])+$/, "Допустимые символы для пароля: a-z A-Z 0-9");

                    if (valid) {
                        $.ajax({
                        url: "${pageContext.request.contextPath}/user/add",
                        type: "GET",
                        data: {username: login.val(),
                               password: password.val(),
                               wage: wage.val()},
                        success: function (data) {
                            if ($.trim(data) === 'false') {                                
                                valid = false;
                            } else {
                                valid = true
                            }
                        },
                        dataType: "text",
                        async: true
                    });                        
                        if(valid){
                            form[ 0 ].reset();
                            allFields.removeClass("ui-state-error");
                            updateTips("Пользователь зарегестрирован!");
                        }
                    }
                    return valid;
                }

                dialog = $("#dialog-form").dialog({
                    autoOpen: false,
                    height: 400,
                    width: 450,
                    modal: true,
                    buttons: {
                        "Добавить пользователя": addUser,
                        "Отмена": function () {
                            dialog.dialog("close");
                        }
                    },
                    close: function () {
                        form[ 0 ].reset();
                        allFields.removeClass("ui-state-error");
                    }
                });

                form = dialog.find("form").on("submit", function (event) {
                    event.preventDefault();
                    addUser();
                });
                $(document).on("click", "a", function(){
                     dialog.dialog("open");});
                });
        </script>
    </head>
    <body>
        <div class="page-login">
            <div class="ui centered grid container">
                <div class="nine wide column">
                    <c:if test="${param.error != null}">
                        <div class="ui icon warning message">
                            <i class="lock icon"></i>
                            <div class="content">
                                <div class="header">
                                    Неудачная попытка входа!
                                </div>
                                <p>Вы наверное ошиблись с логином или паролем. Попробуйте еще раз.</p>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${param.logout != null}">
                        <div class="ui success message">
                            <i class="close icon"></i>
                            <p>Вы успешно вышли из программы.</p>
                        </div>
                    </div>
                </c:if>

                <div class="ui fluid card">
                    <div class="content">
                        <c:url var="loginUrl" value="/login" />
                        <form class="ui form" action="${loginUrl}" method="POST">
                            <div class="field">
                                <label>Логин</label>
                                <input type="text" id="username" name="ssoId" placeholder="Введите Логин" required>
                            </div>
                            <div class="field">
                                <label>Пароль</label>
                                <input type="password" id="password" name="password" placeholder="Введите пароль" required>
                            </div>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <div class="aligned right aligned grid">
                                <button class="ui primary labeled icon button" type="submit">
                                    <i class="unlock alternate icon"></i>
                                    Вход
                                </button>
                            </div>
                        </form>
                        <br/>
                        <div class="aligned right aligned grid">
                            <a id="Reg">Регистрация</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="dialog-form" title="Регистрация">
        <p class="validateTips">Все поля обязательны, кроме баланса.</p> 
        <form action="/registration" method="post">
            <fieldset>
                <label for="login">Логин</label>
                <input type="text" name="reglogin" id="reglogin" placeholder="Введите логин" class="text ui-widget-content ui-corner-all">
                <label for="password">Пароль</label>
                <input type="password" name="regpassword" id="regpassword" class="text ui-widget-content ui-corner-all">
                <label for="name">Баланс</label>
                <input type="text" name="regwage" id="regwage" placeholder="Введите баланс" class="text ui-widget-content ui-corner-all">
                <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
            </fieldset>
        </form>
    </div> 
</body>
</html>

