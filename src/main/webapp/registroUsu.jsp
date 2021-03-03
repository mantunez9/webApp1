<%--
  Created by IntelliJ IDEA.
  User: mantu
  Date: 25/02/2021
  Time: 18:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="form">
    <form action="register" method="post">
        <h1>Registro</h1>
        <p>
            <label for="name">Nombre</label>
            <input id="name" name="name" required="required" type="text" placeholder="Nombre"/>
        </p>
        <p>
            <label for="surnames">Apellidos</label>
            <input id="surnames" name="surnames" required="required" type="text" placeholder="Apellidos"/>
        </p>
        <p>
            <label for="nickName">Nombre usuario</label>
            <input id="nickName" name="nickName" required="required" type="text"
                   placeholder="Nombre usuario"/>
        </p>
        <p>
            <label for="email">Email</label>
            <input id="email" name="email" required="required" type="email" placeholder="ejemplo@mail.com"/>
        </p>
        <p>
            <label for="password">Contraseña</label>
            <input id="password" name="password" required="required" type="password"
                   placeholder="eg. X8df!90EO" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                   title="Debe contener al menos un número y una letra minúscula y mayúscula, y al menos 8 o más caracteres"/>
        </p>
        <p>
            <label for="passwordsignup_confirm">Confirma tu contraseña </label>
            <input id="passwordsignup_confirm" name="passwordsignup_confirm" required="required" type="password"
                   placeholder="eg. X8df!90EO"/>
        </p>
        <br>${message}
        <br><br>
        <p class="signin button">
            <input type="submit" value="Registro"/>
        </p>
        <p class="change_link">
            Ya eres miembro
            <a href="${pageContext.request.contextPath}/login.jsp"> Loguéate </a>
        </p>
    </form>
</div>
</body>
</html>
