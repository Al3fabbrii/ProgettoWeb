<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %><%--
  Created by IntelliJ IDEA.
  User: alessandro
  Date: 26/08/24
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Interfaccia di amministrazione";
%>
<html>
<head>
    <title>Admin Home</title>
    <%@include file="/include/htmlHead.inc"%>

</head>
<body>
<%@include file="/include/adminHeader.jsp"%>


</body>
</html>
