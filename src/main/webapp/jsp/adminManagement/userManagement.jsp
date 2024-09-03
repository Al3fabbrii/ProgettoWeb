<%--
  Created by IntelliJ IDEA.
  User: alessandro
  Date: 02/09/24
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List"%>
<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %>

<%int i = 0;
  boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
  Utente loggedUser = (Utente) request.getAttribute("loggedUser");
  String applicationMessage = (String) request.getAttribute("applicationMessage");
  String menuActiveLink = "Gestione degli utenti";
  List<Utente> users=(List<Utente>) request.getAttribute("users");
  int maxViewSize;
  if(users.size()<8){
    maxViewSize=users.size();
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
    <%@include file="/include/htmlHead.inc"%>
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
    .search-alt-svgrepo{
      width: 60px;
      height: 60px;
      position: relative;
      float: right;
    }
    .user-container{
      justify-content: center;
      text-align:center;
      display:flex;
    }
    .utente{
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
    .user-button{
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
  <script language="JavaScript">
    function searchFunc(name){
      f=document.searchForm;
      f.searchString.value=name;
      f.requestSubmit();
    }

    function setAdmin(id){
      document.setAdminForm.user_id.value=id;
      document.setAdminForm.requestSubmit();
    }

    function deleteUser(id){
      document.deleteForm.user_id.value=id;
      document.deleteForm.requestSubmit();
    }

    function maxViewSizeInc(maxViewSize){
      <%if((maxViewSize+8)>users.size()){%>
      document.loadMoreForm.maxViewSize.value= <%=users.size()%>;
      <%} else{ %>
      document.loadMoreForm.maxViewSize.value=maxViewSize+8;
      <%}%>
      document.loadMoreForm.requestSubmit();
    }

    function mainOnLoadHandler(){}
  </script>

</head>
<body>
  <%@include file="/include/adminHeader.jsp"%>
  <main>
    <div class="search-container">
      <form id="searchForm" name="searchForm" action="Dispatcher" method="post" class="search-form">
        <input type="text" name="searchString" placeholder="Cerca un utente tramite username" class="search-input">
        <input type="hidden" name="controllerAction" value="UserManagement.searchView">
        <img class="search-alt-svgrepo" src="https://www.svgrepo.com/show/532552/search-alt-2.svg" />
        <button type="submit" form="searchForm" hidden="hidden"></button>
      </form>
    </div>
    <h2 class="section-title">Utenti loggati</h2>

    <div class="user-container">
      <% for(i=0;i<users.size();++i){%>
      <div class="utente">
        <div>
          <%=users.get(i).getNome()%> <%=users.get(i).getCognome()%>
        </div>
        <% if(users.get(i).getAdmin().equals("Y")){%>
        <p>Amministratore</p>
        <%}%>
        <p>
          <span>Username: </span><%=users.get(i).getUsername()%>
          <span>ID utente: </span> <%=users.get(i).getId_utente()%>
        </p>
        <% if(!users.get(i).getAdmin().equals("N")){%>
        <button onclick="setAdmin(<%=users.get(i).getId_utente()%>)" class="user-button">
          Rendi amministratore o utente registrato
        </button>
        <%}else{%>
        <button onclick="setAdmin(<%=users.get(i).getId_utente()%>)" class="user-button">
          Rendi amministratore o utente registrato
        </button>
        <%}%>
        <button onclick="deleteUser(<%=users.get(i).getId_utente()%>)" class="delete-button">
          Elimina utente
        </button>
      </div>
      <%}%>
      <div>
        <%if(maxViewSize==users.size()){%>
        <p>Altro</p>
        <%}else{%>
        <a href="javascript:maxViewSizeInc(<%=maxViewSize%>">Altri</a>
        <%}%>
      </div>

    </div>
    <form name="deleteForm" action="Dispatcher" method="post">
      <input type="hidden" name="user_id">
      <input type="hidden" name="controllerAction" value="UserManagement.delete">
    </form>
    <form name="setAdminForm" action="Dispatcher" method="post">
      <input type="hidden" name="user_id">
      <input type="hidden" name="controllerAction" value="UserManagement.setAdmin">
    </form>
    <form name="loadMoreForm" action="Dispatcher" method="post">
      <input type="hidden" name="maxViewSize" value="<%=maxViewSize%>">
      <input type="hidden" name="controllerAction" value="UserManagement.view">
    </form>


  </main>
  <%@include file="/include/footer.inc"%>

</body>
</html>
