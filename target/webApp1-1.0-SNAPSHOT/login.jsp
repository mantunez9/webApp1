<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
<form action="registro" method="post">
    <table>
        <caption><h2>Inicio sesión</h2></caption>
        <tbody>
        <tr>
            <td>Nombre usuario</td>
            <td><label>
                <input name="nickName"/>
            </label></td>
        </tr>
        <tr>
            <td>Contraseña</td>
            <td><label>
                <input name="password" type="password"/>
            </label></td>
        </tr>
        </tbody>
    </table>
    <br>${message}
    <br><br>
    <div>
        <input type="submit"/>
    </div>
</form>
<a href="${pageContext.request.contextPath}/register">
    <button>Registrar</button>
</a>
</body>
</html>



