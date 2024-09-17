<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %>
<%@ page import="com.progettoweb.progettoweb.model.mo.Prodotto" %>
<%@ page import="java.util.List" %>
<%@ page import="com.progettoweb.progettoweb.model.mo.Showcase" %><%--
  Created by IntelliJ IDEA.
  User: alessandro
  Date: 02/09/24
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%int i = 0;
  boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
  Utente loggedUser = (Utente) request.getAttribute("loggedUser");
  String applicationMessage = (String) request.getAttribute("applicationMessage");
  String menuActiveLink = "Gestione della homepage";
  List<Prodotto> products=(List<Prodotto>) request.getAttribute("products");
  List<Showcase> showcases=(List<Showcase>) request.getAttribute("showcases");
%>
<html>
  <head>
    <%@ include file="/include/htmlHead.inc"%>
    <link href="https://fonts.cdnfonts.com/css/games" rel="stylesheet">

    <script>
      function insert(){
        document.insertForm.requestSubmit();
      }
      function deleteItem(id){
        document.deleteForm.id_prod.value=id;
        document.deleteForm.requestSubmit();
      }
      function mainOnLoadHandler(){}
    </script>

    <style>
      .section-title {
        text-align: center;
        font-size: 40px;
        margin-bottom: 10px;
        color: #0a3868;
        font-family: 'Games', sans serif
      }
      .add-image{
        width: 60px;
        height: 60px;
        position: relative;
        float: right;
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
        position:relative;
        float: left;
        background-color:#336699;
        border:2px solid black;
        border-radius: 20px;
        text-align: center;
        font-size:1.2em;
        color:white;
      }
      .delete-button{
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
    <h1 class="section-title">Seleziona i prodotti da mettere in homepage</h1>

    <div>
      <p style="color: black; ">Aggiungi nuovi prodotti in homepage</p>
      <a href="javascript:insertForm.requestSubmit()" class="add-button">
        <img src="https://www.svgrepo.com/show/510786/add-plus-circle.svg" class="add-image">
      </a>
    </div>


    <div class="item-container">
      <%for(i=0;i<showcases.size();++i){%>
      <div class="item">
        <p><%=products.get(i).getNome_prod()%></p>
        <button onclick="deleteItem(<%=products.get(i).getId_prod()%>)" class="delete-button">
          Elimina il prodotto
        </button>
      </div>
      <%}%>
    </div>


    <form name="insertForm" action="Dispatcher" method="post">
      <input type="hidden" name="controllerAction" value="ShowcaseManagement.insertView">
    </form>
    <form name="deleteForm" action="Dispatcher" method="post">
      <input type="hidden" name="id_prod">
      <input type="hidden" name="controllerAction" value="ShowcaseManagement.delete">
    </form>

  </main>

  <%@include file="/include/footer.inc"%>

  </body>
</html>
