<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.progettoweb.progettoweb.model.mo.Prodotto"%>
<%@ page import="com.progettoweb.progettoweb.controller.ShowcaseManagement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="com.progettoweb.progettoweb.services.logservice.LogService" %>
<%@ page import="java.util.logging.Logger" %>

<%
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Home";
    ShowcaseManagement.view(request, response);
    List<Prodotto> products = (List<Prodotto>) request.getAttribute("products");
%>
<html>
<head>
    <title>House of games</title>
    <%@include file="/include/htmlHead.inc"%>
    <link href="https://fonts.cdnfonts.com/css/games" rel="stylesheet">


    <style>
        .product-showcase-container {
            max-width: 80%;
            margin: 0 auto;
            padding: 10px;
            background-color: #f9f9f9;
            border: 2px solid #ccc;
            border-radius: 8px;
            overflow: hidden;
        }
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
            margin: 20px auto; /* Spazio sopra e sotto al divisore */
            width: 95%; /* Larghezza del divisore */
        }

        .contact-section {
            background-color: white;
            text-align: center;
        }
        .contact-details {
            margin-bottom: 30px;
        }

    </style>
    <script language="javascript">

        function productViewFunc(id_prod) {
            f = document.productView;
            f.id_prod.value = id_prod;
            f.requestSubmit();
        }

        function mainOnLoadHandler() {}

    </script>
</head>
<body>
<%@include file="/include/header.jsp"%>

<main>

    <h2 class="section-title">I nostri giochi</h2>
    <div class="product-showcase-container">
        <div class="product-showcase">
            <% for (Prodotto product : products) { %>
            <div class="product-item">
                <a href="javascript:productViewFunc(<%=product.getId_prod()%>)">
                    <img src="<%= product.getImg_path() %>" alt="<%= product.getNome_prod() %>">
                </a>
                <div class="product-details">
                    <h3 style="color: #333; font-size: 18px;"><%= product.getNome_prod() %></h3>
                </div>
            </div>
            <% } %>
        </div>
    </div>

    <hr class="section-divider">

    <div class="contact-section">
        <h2 class="section-title">Contatti</h2>
        <div class="contact-details">
            <p><strong>Telefono:</strong> +39 075 754662</p>
            <p><strong>Email:</strong> contact@HouseOfGames.it</p>
            <p><strong>Sede legale:</strong> SP250, 06081 San Gregorio PG</p>
        </div>
    </div>

    <hr class="section-divider">


    <form name="productView" method="post" action="Dispatcher">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="HomeManagement.productView"/>
    </form>
</main>

<%@include file="/include/footer.inc"%>
</body>
</html>
