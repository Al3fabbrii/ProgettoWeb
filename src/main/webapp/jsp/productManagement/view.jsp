<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %>
<%@ page import="com.progettoweb.progettoweb.model.mo.Prodotto" %>
<%@ page import="java.util.List" %>
<%@ page import="com.progettoweb.progettoweb.services.logservice.LogService" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.util.logging.Level" %><%--
  Created by IntelliJ IDEA.
  User: alessandro
  Date: 26/08/24
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%int i = 0;
    Logger logger= LogService.getApplicationLogger();
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Elenco prodotti";
    List<Prodotto> products=(List<Prodotto>) request.getAttribute("products");

    boolean searchMode=false;
    String searchedItem="";

    try{
        if(request.getAttribute("searchMode")!=null){
            searchMode=(Boolean) request.getAttribute("searchMode");
        }
    } catch (NullPointerException e){
        logger.log(Level.SEVERE, "JSP error (searchMode)", e);

    }

    if(searchMode){
        searchedItem=(String) request.getAttribute("searchedItem");
    }
%>
<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
    <link href="https://fonts.cdnfonts.com/css/games" rel="stylesheet">

    <script>
        function AddToCart(id_prod){
            alert("Aggiunto il prodotto al carrello");
            document.AddToCartForm.id_prod.value=id_prod;
            document.AddToCartForm.requestSubmit();
        }

        function search(name){
            f=document.searchForm;
            f.searchString.value=name;
            f.requestSubmit();
        }

        function productViewFunc(id_prod) {
            f = document.productView;
            f.id_prod.value = id_prod;
            f.requestSubmit();
        }

        function mainOnLoadHandler(){}
    </script>

    <style>
        .search-container{
            background-color: #336699;
            width: 100%;
            display: flex;
            justify-content: center;
            padding: 5px;
        }
        .search-form{
            width:60%;
            max-width: 450px;
            align-items: center;
        }
        .search-input{
            background-color: white;
            margin:auto;
            height: 50px;
            width: 80%;
            border: 2px solid;
            border-color: black;
            border-radius: 20px;
        }
        .section-title {
            text-align: center;
            font-size: 40px;
            margin-bottom: 10px;
            color: #0a3868;
            font-family: 'Games', sans serif;
            margin-top: 10px;
        }
        .item-container{
            width: 90%;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }
        .item{
            position: relative;
            float: left;
            width:30%;
            margin: 10px;
            padding: 5px;
            border: 2px solid black;
        }
        .image{
            position: relative;
            flex-wrap: wrap;
            display: flex;
            max-width:150px;
            max-height: 150px;
            margin: auto;
        }

        .item-name{
            text-align: center;
            font-size: 1.5em;
            color: black;
        }
        .item-price{
            text-align: center;
            font-size: 1.5em;
            color: #d63b18;
        }
        .cart{
            display: flex;
            margin: auto;
            background-color: #0e4bef;
            color: black;
        }
        .image-cart{
            max-width: 40px;
            display: flex;
            justify-content: center;
        }
    </style>
</head>
<body>
<%@include file="/include/header.jsp"%>


    <main>
        <div class="search-container">
            <form id="searchForm" name="searchForm" action="Dispatcher" method="post" class="search-form">
                <input type="text" name="searchString" placeholder="Cerca un gioco" class="search-input">
                <input type="hidden" name="controllerAction" value="HomeManagement.searchView">
                <button type="submit" form="searchForm" hidden="hidden"></button>
            </form>
        </div>

        <%if(!searchedItem.isEmpty()){%>
            <div>
                <%if (searchMode && !products.isEmpty()){%>
                    <h2>Risultato ricerca per: '<%=searchedItem%>'</h2>
                <%}else if(searchMode && products.isEmpty()){%>
                    <h2>Nessun risultato trovato per '<%=searchedItem%>'</h2>
                <%}%>
            </div>
        <%}%>

        <h1 class="section-title">Elenco dei prodotti disponibili</h1>

        <div class="item-container">
            <%for(i=0;i< products.size();++i){%>
                <div class="item">
                    <a href="javascript:productViewFunc(<%=products.get(i).getId_prod()%>)">
                        <img src="<%= products.get(i).getImg_path() %>" alt="<%= products.get(i).getNome_prod() %>" class="image">
                    </a>
                    <div>
                        <div class="item-name"><%=products.get(i).getNome_prod()%></div>
                        <div class="item-price">Prezzo: <%=products.get(i).getPrezzo()%></div>
                    </div>

                    <%if(loggedOn){%>

                    <button onclick="AddToCart(<%=products.get(i).getId_prod()%>)" class="cart">
                        <img src="https://www.svgrepo.com/show/533043/cart-shopping.svg" class="image-cart">
                        <p style="color: white; font-size:1.5em; text-align: center;">Aggiungi al carrello</p>
                    </button>

                    <%}%>
                </div>
            <%}%>
        </div>

        <form name="AddToCartForm" action="Dispatcher" method="post">
            <input type="hidden" name="id_prod">
            <input type="hidden" name="controllerAction" value="CartManagement.AddProduct">
            <input type="hidden" name="viewUrl" value="productManagement/view">
        </form>
        <form name="productView" action="Dispatcher" method="post">
            <input type="hidden" name="id_prod">
            <input type="hidden" name="controllerAction" value="HomeManagement.productView">
        </form>
    </main>
<%@include file="/include/footer.inc"%>
</body>
</html>
