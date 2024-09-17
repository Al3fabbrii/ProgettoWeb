<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %>
<%@ page import="com.progettoweb.progettoweb.model.mo.Prodotto" %><%--
  Created by IntelliJ IDEA.
  User: alessandro
  Date: 04/09/24
  Time: 17:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%int i = 0;
  boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
  Utente loggedUser = (Utente) request.getAttribute("loggedUser");
  String applicationMessage = (String) request.getAttribute("applicationMessage");
  Prodotto prodotto=(Prodotto) request.getAttribute("prodotto");
  String menuActiveLink = prodotto.getNome_prod();
%>
<html>
<head>
  <%@ include file="/include/htmlHead.inc"%>
  <script>
    function AddToCart(id_prod){
      alert("Aggiunto il prodotto al carrello");
      document.AddToCartForm.id_prod.value=id_prod;
      document.AddToCartForm.requestSubmit();
    }
    function productView(id_prod){
      f=document.productView;
      f.id_prod.value=id_prod;
      f.requestSubmit();
    }
    function mainOnLoadHandler(){}

  </script>

  <style>

    .image-show{
      max-width: 50%;
    }
    .image-section{
      justify-content: center;
      display: flex;
      max-width: 100%;
      margin: auto;
      padding: 10px;
    }
    .info{
      border: 2px solid black;
      border-radius: 25px;
      width:50%;
      margin: auto;
      margin-top:10px;
      margin-bottom: 10px;
      background-color: #4e9bdb;
    }
    .warning-container{
      display: flex;
      justify-content: center;
      align-items: center;
      align-content: center;
    }
    .price{
      text-align: center;
      font-size: 2em;
      color: black;
    }
    .image-warning{
      max-width: 75px;
      display: flex;
      justify-content: center;
    }
    .image-cart{
      max-width: 75px;
      display: flex;
      justify-content: center;
    }
    .description{
      text-align: center;
      font-size: 2em;
      color: black;
    }
    .annulla{
      font-size: 1.5em;
      background-color: #4e9bdb;
      border: 2px solid black;
      border-radius: 10px;
      width: 30%;
      display: flex;
      margin:auto;
      margin-bottom: 10px;
      justify-content: center;
    }
    .section-divider {
      border: none;
      height: 2px;
      background-color: black;
      margin: 20px auto;
      width: 95%;
    }

  </style>
</head>
<body>
<%@ include file="/include/header.jsp"%>

  <main>
    <div class="container">
      <div class="image-section">
        <img src="<%=prodotto.getImg_path()%>" alt="Immagine del gioco" class="image-show">
      </div>

      <div class="info">
        <h1 style="color:black; font-size: 2.5em;"><%=prodotto.getNome_prod()%></h1>

        <p class="price">Prezzo: <%=prodotto.getPrezzo()%></p>

        <%if(!loggedOn){%>
        <div class="warning-container">
          <img src="https://www.svgrepo.com/show/521262/warning-circle.svg" class="image-warning">
          <p style="color: black;">Prima di poter aggiungere un prodotto al carrello devi accedere, clicca sul profilo in alto a destra</p>
        </div>
        <%}%>
        <%if(loggedOn){%>
        <div class="warning-container">
          <img class="image-cart" src="https://www.svgrepo.com/show/533043/cart-shopping.svg">
          <p style="color: black;" onclick="AddToCart(<%=prodotto.getId_prod()%>)">Aggiungi al carrello</p>
        </div>
        <%}%>
        <div>
          <h2 style="color: black; text-align: center; font-size: 2em;">Descrizione</h2>
          <p class="description"><%=prodotto.getDescrizione()%></p>
          <hr class="section-divider">
          <h2 style="color: black; text-align: center; font-size: 2em;">Categoria del gioco</h2>
          <p class="description"><%=prodotto.getCategoria()%></p>
        </div>
      </div>

      <button class="annulla" onclick="location.href='Dispatcher?controllerAction=ProductManagement.view'">Catalogo completo</button>

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

<%@ include file="/include/footer.inc"%>

</body>
</html>
