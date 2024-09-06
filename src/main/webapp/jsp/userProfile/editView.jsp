<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %><%--
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
    Utente user=(Utente) request.getAttribute("user");
    String menuActiveLink = "Modifica Profilo";
    String action=(user!=null)? "modify" : "insert";
%>
<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
    <script>
        var status="<%=action%>";

        function DynamicFormCheck_int(e){
            var EventTriggerName= (e.target.id);
            var EventTriggerValue= (e.target.value);

            if(isNaN(EventTriggerValue)){
                alert("Il campo '"+EventTriggerName+"' richiede un numero");
            }
        }

        function goBack(){
            document.backForm.requestSubmit();
        }

        function mainOnLoadHandler(){}
    </script>

    <style>
        .input{
            background-color: white;
            border: 2px solid black;
            border-radius: 10px;
            text-align: center;
            color: black;
            font-size: 1.2em;
            display:flex;
            margin:auto;
        }
        .label{
            font-size: 1.5em;
            color: black;
            display:flex;
            justify-content: center;
        }
        .confirm{
            display: flex;
            margin:auto;
            max-width: 20%;
            background-color: #336699;
            color: white;
            border: 2px solid black;
            border-radius: 15px;
            text-align: center;
            font-size:1.5em;
            margin-top:10px;
            margin-bottom: 10px;
        }
        .subsection-title{
            font-size: 2em;
            color: black;
            text-align: center;
        }
        .delete-button{
            display: flex;
            margin: auto;
            font-size: 2em;
            background-color: #d63b18;
            color: white;
            border: 2px solid black;
            border-radius: 20px;
        }
        .user-info{
            margin:auto;
        }
        .address-info{
            margin:auto;
        }
        .payment-info{
            margin:auto;
        }
        .section-divider {
            border: none;
            height: 2px;
            background-color: #336699;
            margin: 20px auto;
            width: 95%;
        }
    </style>
</head>
<body>
<%@include file="/include/header.jsp"%>
    <main>
        <h1>Modifica Profilo</h1>
        <div class="user-info">
            <h2 class="subsection-title">Info utente</h2>
            <label for="Username" class="label">Username</label>
            <input class="input" id="Username" name="Username" form="editProfileForm" type="text" placeholder="Nome utente" value="<%=(user.getUsername()!=null) ? user.getUsername() : ""%>">
            <label for="Password" class="label">Password</label>
            <input class="input" id="Password" name="Password" form="editProfileForm" type="text" placeholder="Password" value="<%=(user.getPassword()!=null) ? user.getPassword() : ""%>">
            <label for="Nome" class="label">Nome</label>
            <input class="input" id="Nome" name="Nome" form="editProfileForm" type="text" placeholder="Nome" value="<%=(user.getNome()!=null) ? user.getNome() : ""%>">
            <label for="Cognome" class="label">Cognome</label>
            <input class="input" id="Cognome" name="Cognome" form="editProfileForm" type="text" placeholder="Cognome" value="<%=(user.getCognome()!=null) ? user.getCognome() : ""%>">
            <label for="Email" class="label">Email</label>
            <input class="input" id="Email" name="Email" form="editProfileForm" type="text" placeholder="Email" value="<%=(user.getEmail()!=null) ? user.getEmail() : ""%>">
        </div>

        <hr class="section-divider">
        <div class="payment-info">
            <h2 class="subsection-title">Info di pagamento</h2>
            <button type="submit" form="deleteCarta" class="delete-button">
                Elimina le informazioni di pagamento
            </button>

            <label for="card_n" class="label">Numero di carta</label>
            <input class="input" id="card_n" name="card_n" form="editProfileForm" type="text" placeholder="Numero carta" value="<%=(user.getCard_n()!=null) ? user.getCard_n() : ""%>">
            <label for="cvc" class="label">CVC</label>
            <input class="input" id="cvc" name="cvc" form="editProfileForm" type="text" placeholder="CVC" value="<%=(user.getCvc()!=0) ? user.getCvc() : ""%>">
            <label for="exp_date" class="label">Data di scadenza</label>
            <input class="input" id="exp_date" name="exp_date" form="editProfileForm" type="text" placeholder="Data scadenza" value="<%=(user.getExp_date()!=null) ? user.getExp_date() : ""%>">

        </div>
        <hr class="section-divider">

        <div class="address-info">
            <h2 class="subsection-title">Info di fatturazione</h2>
            <button type="submit" form="deleteFatturazione" class="delete-button">
                Elimina le informazioni di fatturazione
            </button>

            <label for="Indirizzo" class="label">Indirizzo</label>
            <input class="input" id="Indirizzo" name="Indirizzo" form="editProfileForm" type="text" placeholder="Indirizzo" value="<%=(user.getIndirizzo()!=null) ? user.getIndirizzo() : ""%>">
            <label for="CAP" class="label">CAP</label>
            <input class="input" id="CAP" name="CAP" form="editProfileForm" type="text" placeholder="CAP" value="<%=(user.getCap()!=0) ? user.getCap() : ""%>">
            <label for="Città" class="label">Città</label>
            <input class="input" id="Città" name="Città" form="editProfileForm" type="text" placeholder="Città" value="<%=(user.getCitta()!=null) ? user.getCitta() : ""%>">

        </div>

        <button class="confirm" onclick="editProfileForm.requestSubmit()">
            Conferma le modifiche
        </button>
        <button class="confirm" onclick="goBack()">
            Annulla le modifiche
        </button>
        <hr class="section-divider">

    </main>

    <form id="editProfileForm" name="editProfileForm" action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="UserProfile.modify">
    </form>
    <form id="deleteCarta" name="deleteCarta" action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="UserProfile.deleteCarta">
    </form>
    <form id="deleteFatturazione" name="deleteFatturazione" action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="UserProfile.deleteSpedizione">
    </form>
    <form id="backForm" name="backForm" action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="UserProfile.view">
    </form>
<%@include file="/include/footer.inc"%>
</body>
</html>
