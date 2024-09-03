<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %><%--
  Created by IntelliJ IDEA.
  User: alessandro
  Date: 02/09/24
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List"%>
<%@ page import="com.progettoweb.progettoweb.model.mo.Prodotto" %>
<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Gestione dei prodotti";
    List<Prodotto> products=(List<Prodotto>) request.getAttribute("products");
    int maxViewSize;
    if(products.size()<8){
        maxViewSize=products.size();
    }
    else{
        maxViewSize=0;
    }
    try{
        maxViewSize=(Integer) request.getAttribute("maxViewSize");
    } catch (NullPointerException e) {
    }
%>
<html>
<head>
    <title>Title</title>
    <%@ include file="/include/htmlHead.inc"%>

    <script language="JavaScript">
        function insertItem(){
            document.insertForm.requestSubmit();
        }

        function deleteItem(id){
            document.deleteForm.id_prod.value=id;
            document.deleteForm.requestSubmit();
        }

        function modifyItem(id){
            document.modifyForm.id_prod.value=id;
            document.modifyForm.requestSubmit();
        }
        function search(name){
            f=document.searchForm;
            f.searchString.value=name;
            f.requestSubmit();
        }

        function maxViewSizeInc(maxViewSize){
            <%if((maxViewSize+8)>products.size()){%>
            document.loadMoreForm.maxViewSize.value= <%=products.size()%>;
            <%} else{ %>
            document.loadMoreForm.maxViewSize.value=maxViewSize+8;
            <%}%>
            document.loadMoreForm.requestSubmit();
        }
        function mainOnLoadHandler(){}

    </script>

    <style>
        .section-title {
            text-align: center;
            font-size: 40px;
            margin-bottom: 10px;
            color: #0a3868;
        }

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
        .add-image{
            width: 60px;
            height: 60px;
            position: relative;
            float: right;
        }
        .item-container{
            justify-content: center;
            text-align:center;
            display:flex;
        }
        .item{
            padding:10px;
            color:black;
            border: 2px solid;
            margin:10px;
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
        .modify-button{
            text-align: center;
            font-size: 1.2em;
            background-color: #336699;
            color:white;
            border:2px solid;
            border-radius:10px;
            border-color: black;
            padding:5px;
        }
    </style>
</head>
<body>
<%@include file="/include/adminHeader.jsp"%>

<main>
    <div class="search-container">
        <form id="searchForm" name="searchForm" action="Dispatcher" method="post" class="search-form">
            <input type="text" name="searchString" placeholder="Cerca un utente tramite username" class="search-input">
            <input type="hidden" name="controllerAction" value="UserManagement.searchView">
            <button type="submit" form="searchForm" hidden="hidden"></button>
        </form>
    </div>

    <h2 class="section-title">Elenco dei prodotti:</h2>

    <button onclick="insertItem()" class="add-button">Aggiungi nuovi prodotti
        <img src="https://www.svgrepo.com/show/510786/add-plus-circle.svg" class="add-image">
    </button>


    <div class="item-container">
        <%for(i=0;i<maxViewSize;++i){%>
        <div class="item">
            <div>
                <%=products.get(i).getNome_prod()%>
            </div>
            <p><%=products.get(i).getQuantita_disponibile()%></p>
            <button onclick="modifyItem()" class="modify-button">
                Modifica il prodotto
            </button>
            <button onclick="deleteItem()" class="delete-button">
                Elimina il prodotto
            </button>
        </div>
        <%}%>
        <div>
            <%if(maxViewSize==products.size()){%>
            <p>Altro</p>
            <%}else{%>
            <a href="javascript:maxViewSizeInc(<%=maxViewSize%>">Altri</a>
            <%}%>
        </div>
    </div>

    <form name="insertForm" action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="ProductManagement.insertView"/>
    </form>
    <form name="deleteForm" action="Dispatcher" method="post">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="ProductManagement.delete"/>
    </form>
    <form name="modifyForm" action="Dispatcher" method="post">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="ProductManagement.modifyView"/>
    </form>
    <form name="loadMoreForm" action="Dispatcher" method="post">
        <input type="hidden" name="maxViewSize" value="<%=maxViewSize%>"/>
        <input type="hidden" name="controllerAction" value="ProductManagement.viewManagement"/>
    </form>
</main>

<%@include file="/include/footer.inc"%>
</body>
</html>
