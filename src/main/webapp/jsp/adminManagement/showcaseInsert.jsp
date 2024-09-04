<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %>
<%@ page import="com.progettoweb.progettoweb.model.mo.Prodotto" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: alessandro
  Date: 04/09/24
  Time: 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%int i = 0;
  boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
  Utente loggedUser = (Utente) request.getAttribute("loggedUser");
  String applicationMessage = (String) request.getAttribute("applicationMessage");
  String menuActiveLink = "Aggiunta prodotti in homepage";
  List<Prodotto> products=(List<Prodotto>) request.getAttribute("products");
%>
<html>
<head>
  <%@ include file="/include/htmlHead.inc"%>

  <script>
     function insert(id_prod){
       f=document.insertForm;
       f.id_prod.value=id_prod;
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
    .item-container{
      justify-content: center ;
      text-align:center;
      display:flex;
      flex-wrap: wrap;
    }
    .item{
      padding:10px;
      color:black;
      border: 2px solid;
      margin:10px;
    }
    .add-button{
      text-align: center;
      font-size: 1.2em;
      background-color: #336699;
      color:white;
      border:2px solid;
      border-radius:10px;
      border-color: black;
      padding: 5px;
    }
  </style>
</head>
<body>
<%@include file="/include/adminHeader.jsp"%>

<main>
  <div class="search-container">
    <form id="searchForm" name="searchForm" action="Dispatcher" method="post" class="search-form">
      <input type="text" name="searchString" placeholder="Cerca un prodotto da aggiungere" class="search-input">
      <input type="hidden" name="controllerAction" value="ShowcaseManagement.searchView">
      <button type="submit" form="searchForm" hidden="hidden"></button>
    </form>
  </div>

  <div class="item-container">
    <%for(i=0;i<products.size();++i){%>
    <div class="item">
      <div>
        <%=products.get(i).getNome_prod()%>
      </div>
      <p>Quantità presente: <%=products.get(i).getQuantita_disponibile()%></p>
      <p>Prezzo attuale: <%=products.get(i).getPrezzo()%></p>
      <button onclick="insert(<%=products.get(i).getId_prod()%>)" class="add-button">
        Aggiungi il prodotto
      </button>
    </div>
    <%}%>
  </div>

  <form name="insertForm" action="Dispatcher" method="post">
    <input type="hidden" name="id_prod">
    <input type="hidden" name="controllerAction" value="ShowcaseManagement.insert">
  </form>
</main>

<%@include file="/include/footer.inc"%>

</body>
</html>
