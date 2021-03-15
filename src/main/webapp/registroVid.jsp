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
<link rel="stylesheet" type="text/css" href="css/style.css">
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <meta http-equiv="Content-Type"
          content="text/html; charset=windows-1256">
    <title>Video</title>
    <link rel="stylesheet" type="text/css" href="css/dropdown.css">
</head>
<body>
<div class="dropdown">
    <button class="dropbtn">${user.nickName}</button>
    <div class="dropdown-content">
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>
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

<div style="padding: 8% 0 0;">
    <div style="background: #FFFFFF; padding: 15px; text-align: center;">
        <table id="videoTable" class="flat-table">
            <h1>List of videos</h1>
            <thead>
            <tr>
                <th onclick="sortTable(0)">Title</th>
                <th onclick="sortTable(1)">Author</th>
                <th onclick="sortTable(2)">Creation date</th>
                <th onclick="sortTable(3)">Time</th>
                <th onclick="sortTable(4)">Number of reproductions</th>
                <th onclick="sortTable(5)">Description</th>
                <th onclick="sortTable(6)">Format</th>
                <th onclick="sortTable(7)">Url</th>
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
        <script>
            function sortTable(n) {
                var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
                table = document.getElementById("videoTable");
                switching = true;
                dir = "asc";
                while (switching) {
                    switching = false;
                    rows = table.rows;
                    for (i = 1; i < (rows.length - 1); i++) {
                        shouldSwitch = false;
                        x = rows[i].getElementsByTagName("TD")[n];
                        y = rows[i + 1].getElementsByTagName("TD")[n];
                        if (dir === "asc") {
                            if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                                shouldSwitch = true;
                                break;
                            }
                        } else if (dir === "desc") {
                            if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                                shouldSwitch = true;
                                break;
                            }
                        }
                    }
                    if (shouldSwitch) {
                        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                        switching = true;
                        switchcount++;
                    } else {
                        if (switchcount === 0 && dir === "asc") {
                            dir = "desc";
                            switching = true;
                        }
                    }
                }
            }
        </script>
    </div>
</div>
</body>
</html>
