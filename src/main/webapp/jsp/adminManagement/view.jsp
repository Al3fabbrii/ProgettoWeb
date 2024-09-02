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
    <style>
        .section-title {
            text-align: center;
            font-size: 40px;
            margin-bottom: 10px;
            color: #0a3868;
            font-family: 'Games', sans serif
        }
        .section-divider {
            border: none;
            height: 2px;
            background-color: #336699;
            margin: 20px auto;
            width: 95%;
        }
        .container{
            margin:auto;
            border-color: black;
        }
        .button{
            display: block;
            margin: auto;
            font-size: 2em;
            color: black;
            border-color: black;
        }
    </style>
</head>
<body>
<%@include file="/include/adminHeader.jsp"%>

<main>
    <h2 class="section-title">Gestione dei prodotti</h2>
    <div class="container2">
        <button onclick="location.href='Dispatcher?controllerAction=ProductManagement.viewManagement'" class="button2">
            Seleziona per gestire i tuoi prodotti
        </button>
    </div>

    <hr class="section-divider">

    <h2 class="section-title">Gestione degli utenti</h2>
    <div class="container">
        <button onclick="location.href='Dispatcher?controllerAction=UserManagement.view'" class="button">
            Seleziona per gestire gli utenti loggati
        </button>
    </div>
    <hr class="section-divider">

    <h2 class="section-title">Gestione dei prodotti in Homepage</h2>
    <div class="container">
        <button onclick="location.href='Dispatcher?controllerAction=ShowcaseManagement.view'" class="button">
            Seleziona per modificare i giochi presenti in Homepage
        </button>
    </div>
    <hr class="section-divider">
</main>

<%@include file="/include/footer.inc"%>
</body>
</html>
