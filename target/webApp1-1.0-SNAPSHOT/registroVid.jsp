<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="user" scope="session" type="isdcm.webapp.model.User"/>
<%--
  Created by IntelliJ IDEA.
  User: mantu
  Date: 25/02/2021
  Time: 20:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type"
          content="text/html; charset=windows-1256">
    <title></title>
</head>
<body>
<b>Usuario ${user.nickName} Logueado</b>
<br><br>
<form action="video" method="post">
    <h1>Registro Video</h1>
    <p>
        <label for="titulo">Título</label>
        <input id="titulo" name="titulo" required="required" type="text" placeholder="Título"/>
    </p>
    <p>
        <label for="autor">Autor</label>
        <input id="autor" name="autor" required="required" type="text"
               placeholder="Autor"/>
    </p>
    <p>
        <label for="date">Fecha creación</label>
        <input id="date" name="date" required="required" type="date" placeholder="DD/MM/YYYY"/>
    </p>
    <p>
        <label for="duracion">Duración</label>
        <input id="duracion" name="duracion" required="required" type="text"
               pattern="^(?:(?:([01]?\d|2[0-3]):)([0-5]?\d):)([0-5]?\d)$"
               placeholder="mm:ss:nn"/>
    </p>
    <p>
        <label for="reproducciones">Número de reproducciones</label>
        <input id="reproducciones" name="reproducciones" required="required" type="number"
               placeholder="Número de reproducciones"/>
    </p>
    <p>
        <label for="descripcion">Descripción</label>
        <input id="descripcion" name="descripcion" required="required" type="text" placeholder="Descripción"/>
    </p>
    <p>
        <label for="formato">Formato</label>
        <input id="formato" name="formato" required="required" type="text" placeholder="mp4"/>
    </p>
    <p class="button">
        <input type="submit" value="Registro"/>
    </p>
</form>

<table>
    <caption><h2>Lista de videos</h2></caption>
    <thead>
    <tr>
        <th>Título</th>
        <th>Autor</th>
        <th>Fecha creación</th>
        <th>Duración</th>
        <th>Número de reproducciones</th>
        <th>Descripción</th>
        <th>Formato</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${videos}" var="video">
        <tr>
            <td>${video.tittle}</td>
            <td>${video.author}</td>
            <td>${video.creationDate}</td>
            <td>${video.duration}</td>
            <td>${video.reproduction}</td>
            <td>${video.description}</td>
            <td>${video.format}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<a href="${pageContext.request.contextPath}/logout">Logout</a>
</body>
</html>
