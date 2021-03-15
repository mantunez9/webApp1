<%--
  Created by IntelliJ IDEA.
  User: mantu
  Date: 15/03/2021
  Time: 19:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isErrorPage="true" %>
<html>
<head>
    <title>Error</title>
</head>
<body>
<h3>Sorry an exception occured!</h3>
<p class="error-message"> ${error} </p>
<%= exception %>
<a href="${pageContext.request.contextPath}/login">Log In</a>
</body>
</html>
