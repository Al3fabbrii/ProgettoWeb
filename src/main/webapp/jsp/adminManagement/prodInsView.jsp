<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %>
<%@ page import="com.progettoweb.progettoweb.model.mo.Prodotto" %><%--
  Created by IntelliJ IDEA.
  User: alessandro
  Date: 03/09/24
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Inserimento dei prodotti";
%>
<html>
<head>
    <%@ include file="/include/htmlHead.inc"%>
    <script language="JavaScript">
        function DynamicFormCheck(e){
            var EventTriggerName=(e.target.name);
            var EventTriggerValue=(e.target.value);

            if(isNaN(EventTriggerValue))
                alert("Il campo "+EventTriggerName+" richiede un numero");
        }

        function StaticFormCheck() {
            var prezzoValue = document.getElementById("Prezzo").value;
            var avalaibilityValue = document.getElementById("Quantità").value;

            if (isNaN(prezzoValue)) {
                alert("Il campo PREZZO richiede un numero valido");
                return false;
            }

            if (isNaN(avalaibilityValue)) {
                alert("Il campo QUANTITÀ richiede un numero valido");
                return false;
            }

            return true;
        }

        function submitItem(){
            if(StaticFormCheck()){
                document.insForm.controllerAction.value="ProductManagement.insert";
                document.insForm.submit();
            }
        }

        function back(){
            document.backForm.requestSubmit();
        }

        function mainOnLoadHandler(){
            document.insForm.Invia.addEventListener("click",submitItem);
            document.insForm.backButton.addEventListener("click",back);
            document.insForm.Prezzo.addEventListener("change",DynamicFormCheck);
            document.insForm.Quantità.addEventListener("change",DynamicFormCheck);
        }
    </script>

    <style>
        .input-container{
            background-color: #336699;
            border: 2px solid black;
            border-radius: 10px;
            color: white;
            text-align: center;
            width: 50%;
            margin: auto;
            padding: 5px;
            margin-bottom: 10px;
        }
        .input-text{
            border: 2px solid black;
            font-size:1em;
            color: black;
            padding: 5px;
        }
        .submit-button{
            position: relative;
            margin-left: 10px;
            padding: 5px;
            float: right;
            width: 10%;
            height: auto;
            text-align: center;
            color: white;
            font-size: 2em;
            background-color: #0a3868;
            border: 2px solid black;
            border-radius: 10px;
        }
        .back-button{
            position: relative;
            margin-left: 10px;
            padding: 5px;
            float: right;
            width: 10%;
            height: auto;
            font-size: 2em;
            text-align: center;
            color: black;
            background-color: #4e9bdb;
            border: 2px solid black;
            border-radius: 10px;
        }
    </style>
</head>
<body>
<%@include file="/include/adminHeader.jsp"%>
<main>
    <h1>Gestione nuovo prodotto</h1>
    <section>
        <form name="insForm" action="Dispatcher" method="post" style="margin-bottom: 100px;">
            <div class="input-container">
                <label for="Nome">Nome</label>
                <input type="text" id="Nome" name="Nome" placeholder="Nome prodotto" class="input-text" required>
            </div>
            <div class="input-container">
                <label for="Prezzo">Prezzo</label>
                <input type="text" id="Prezzo" name="Prezzo" placeholder="Prezzo prodotto" class="input-text"  required>
            </div>
            <div class="input-container">
                <label for="Quantità">Quantità</label>
                <input type="text" id="Quantità" name="Quantità" placeholder="Quantità prodotto" class="input-text"  required>
            </div>
            <div class="input-container">
                <label for="Descrizione">Descrizione</label>
                <input type="text" id="Descrizione" name="Descrizione" placeholder="Descrizione prodotto" class="input-text"  required>
            </div>
            <div class="input-container">
                <label for="Categoria">Categoria</label>
                <input type="text" id="Categoria" name="Categoria" placeholder="Categoria prodotto" class="input-text"  required>
            </div>
            <div class="input-container">
                <label for="URL">URL immagine</label>
                <input type="text" id="URL" name="URL" placeholder="URL immagine" class="input-text"  required>
            </div>
            <input type="button" name="Invia" value="Conferma" onclick="submitItem()" class="submit-button"/>
            <input type="button" name="backButton" value="Annulla" onclick="back()" class="back-button">
            <input type="hidden" name="controllerAction">

        </form>
    </section>

    <form name="backForm" action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="ProductManagement.viewManagement"/>
    </form>
</main>

<%@include file="/include/footer.inc"%>
</body>
</html>
