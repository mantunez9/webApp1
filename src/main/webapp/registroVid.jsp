<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="user" scope="session" type="isdcm.webapp.model.User"/>
<%--
  Created by IntelliJ IDEA.
  User: mantu
  Date: 25/02/2021
  Time: 20:15
  To change this template use File | Settings | File Templates.
--%>

<% HttpSession nsession = request.getSession(false);
    if (nsession == null) {
%>
<jsp:forward page="login.jsp"/>
<%
    }
%>
<%@ page contentType="text/html;charset=UTF-8" %>
<link rel="stylesheet" type="text/css" href="css/style.css">
<html>
<head>
    <meta http-equiv="Content-Type"
          content="text/html; charset=windows-1256">
    <title>Video</title>
</head>
<body>
<b>User ${user.nickName} logged in</b>
<a href="${pageContext.request.contextPath}/logout">Logout</a>
<br><br>
<div class="video-page">
    <div class="video-form">
        <h1>Video Registration</h1>
        <form action="video" method="post">
            <p>
                <label for="titulo">Title: </label>
                <input id="titulo" name="titulo" required="required" type="text" placeholder="title"/>
            </p>
            <p>
                <label for="autor">Author:</label>
                <input id="autor" name="autor" required="required" type="text"
                       placeholder="author"/>
            </p>
            <p>
                <label for="date">Creation date:</label>
                <input id="date" name="date" required="required" type="date" placeholder="DD/MM/YYYY"/>
            </p>
            <p>
                <label for="duracion">Duration time:</label>
                <input id="duracion" name="duracion" required="required" type="text"
                       pattern="^(?:(?:([01]?\d|2[0-3]):)([0-5]?\d):)([0-5]?\d)$"
                       placeholder="mm:ss:nn"/>
            </p>
            <p>
                <label for="reproducciones">Number of reproductions:</label>
                <input id="reproducciones" name="reproducciones" required="required" type="number" min="0"
                       placeholder="number of reproductions"/>
            </p>
            <p>
                <label for="descripcion">Description:</label>
                <input id="descripcion" name="descripcion" required="required" type="text" placeholder="description"/>
            </p>
            <p>
                <label for="formato">Format</label>
                <input id="formato" name="formato" required="required" type="text" placeholder="mp4"/>
            </p>
            <p>
                <label for="url">url</label>
                <input id="url" name="url" type="url" placeholder="www.youtube.com/example"/>
            </p>
            <button type="submit">create</button>
        </form>
    </div>
</div>

<div class="video-page">
    <div class="video-form">
        <table class="flat-table">
            <h1>List of videos</h1>
            <thead>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Creation date</th>
                <th>Time</th>
                <th>Number of reproductions</th>
                <th>Description</th>
                <th>Format</th>
                <th>Url</th>
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
                    <td>${video.url}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
