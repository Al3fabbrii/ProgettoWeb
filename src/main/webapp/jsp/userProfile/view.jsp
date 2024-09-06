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
    Utente user=(Utente) request.getAttribute("user");
    String menuActiveLink = user.getNome();
%>

<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
    <link href="https://fonts.cdnfonts.com/css/games" rel="stylesheet">

    <script>
        function deletePrompt(){
            let deleteConfirmation =confirm("sei sicuro di voler eliminare il tuo profilo?");
            return deleteConfirmation;
        }

        function deleteProfile(){
            if(deletePrompt()){
                document.deleteProfileForm.requestSubmit();
            }
        }
        function mainOnLoadHandler(){}
    </script>

    <style>
        .section-title {
            text-align: center;
            font-size: 40px;
            margin-bottom: 10px;
            color: #0a3868;
            font-family: 'Games', sans serif;
            letter-spacing: 2px;
        }
        .modify{
            display: flex;
            margin:auto;
            max-width: 20%;
            background-color: #336699;
            color: white;
            border: 2px solid black;
            border-radius: 15px;
            text-align: center;
            font-size:1.5em;
            margin-bottom: 10px;
        }
        .delete{
            display: flex;
            margin:auto;
            max-width: 20%;
            background-color: #336699;
            color: white;
            border: 2px solid black;
            border-radius: 15px;
            text-align: center;
            font-size:1.5em;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<%@include file="/include/header.jsp"%>

    <main>
        <div>
            <h1 class="section-title"><%=user.getNome()%></h1>
            <p style="text-align: center; font-size: 1.5em; color: black; margin-bottom: 10px;" ><span>Nome utente: </span><%=user.getUsername()%></p>
            <p style="text-align: center; font-size: 1.5em; color: black; margin-bottom: 10px;" ><span>Nome: </span><%=user.getNome()%></p>
            <p style="text-align: center; font-size: 1.5em; color: black; margin-bottom: 10px;" ><span>Cognome: </span><%=user.getCognome()%></p>
            <%if(user.getEmail()!=null){%>
                <p style="text-align: center; font-size: 1.5em; color: black; margin-bottom: 10px;" ><span>Email: </span><%=user.getEmail()%></p>
            <%}%>
        </div>
        <button class="modify" onclick="editProfileViewForm.requestSubmit()">
            Modifica il profilo
        </button>
        <button class="delete" onclick="deleteProfile()">
            Elimina il profilo
        </button>
    </main>

    <form name="editProfileViewForm" method="post" action="Dispatcher" id="editProfileViewForm">
        <input name="controllerAction" type="hidden" value="UserProfile.editProfileView">
    </form>

    <form name="deleteProfileForm" method="post" action="Dispatcher" id="deleteProfileForm">
        <input name="controllerAction" type="hidden" value="UserProfile.deleteProfile">
    </form>
<%@include file="/include/footer.inc"%>
</body>
</html>
