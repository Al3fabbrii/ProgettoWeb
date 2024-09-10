<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %>
<%@ page import="com.progettoweb.progettoweb.model.mo.Cart" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.math.RoundingMode" %><%--
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
    String menuActiveLink = "Pagamento";
    List<Cart> carts=(List<Cart>) request.getAttribute("carts");
    Utente user=(Utente) request.getAttribute("user");

    BigDecimal total_amount=(BigDecimal) request.getAttribute("total_amount");
%>
<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
    <link href="https://fonts.cdnfonts.com/css/games" rel="stylesheet">

    <script language="JavaScript">
        var now=Date.now();
        var nowDate=new Date(now);

        function StaticFormCheck(){
            var card_number=document.CompleteOrderForm.card_n.value;
            var cvc =document.CompleteOrderForm.cvc.value;
            var data= Date.parse("01/"+document.CompleteOrderForm.exp_date.value);

            if(isNaN(card_number)){
                alert("il campo 'Numero di carta' deve essere un numero");
                return false;
            }
            if(isNaN(cvc)){
                alert("il campo 'CVC' deve essere un numero");
                return false;
            }
            if(isNaN(data)){
                alert("il campo 'Data di scadenza' deve essere una data");
                return false;
            }
            return true;
        }

        function DynamicFormCheck_int(e){
            var EventTriggerName= (e.target.id);
            var EventTriggerValue= (e.target.value);

            if(isNaN(EventTriggerValue)){
                alert("Il campo '"+EventTriggerName+"' richiede un numero");
            }
        }

        function CompleteOrder(){
            if(StaticFormCheck()){
                document.CompleteOrderForm.requestSubmit();
            }
        }

        function mainOnLoadHandler(){
            document.CompleteOrderForm.card_n.addEventListener("change", DynamicFormCheck_int);
            document.CompleteOrderForm.cvc.addEventListener("change", DynamicFormCheck_int);
        }
    </script>

    <style>
        .payment{
            margin: auto;
        }
        .input-button{
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
        .subsection-title{
            font-size: 2em;
            color: black;
            text-align: center;
        }
        .section-title {
            text-align: center;
            font-size: 40px;
            margin-bottom: 10px;
            color: #0a3868;
            font-family: 'Games', sans serif;
            letter-spacing: 2px;
        }
        .section-divider {
            border: none;
            height: 2px;
            background-color: #336699;
            margin: 20px auto;
            width: 95%;
        }
        .address{
            margin:auto;
        }
        .riepilogo{
            margin: auto;
        }
        .acquista{
            position: relative;
            float: right;
            max-width: 20%;
            background-color: #336699;
            color: white;
            border: 2px solid black;
            border-radius: 15px;
            margin-left: 10px;
            text-align: center;
            font-size:1.5em;
            margin-bottom: 10px;
        }
        .annulla{
            position: relative;
            float: right;
            max-width: 20%;
            background-color: #336699;
            color: white;
            border: 2px solid black;
            border-radius: 15px;
            margin-left: 10px;
            text-align: center;
            font-size:1.5em;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<%@include file="/include/header.jsp"%>

    <main>
        <h1 class="section-title">Pagamento e riepilogo ordine</h1>

        <div class="payment">
            <h2 class="subsection-title">Pagamento</h2>

            <label for="card_n" class="label">Numero di carta</label>
            <input form="CompleteOrderForm" class="input-button" name="card_n" id="card_n" type="text" placeholder="Numero della carta" value="<%=(user.getCard_n() != null) ? user.getCard_n() : "" %>">
            <label for="cvc" class="label">CVC</label>
            <input form="CompleteOrderForm" class="input-button" name="cvc" id="cvc" type="text" placeholder="CVC" value="<%=(user.getCvc() != 0) ? user.getCvc() : "" %>">
            <label for="exp_date" class="label">Data di scadenza</label>
            <input form="CompleteOrderForm" class="input-button" name="exp_date" id="exp_date" type="text" placeholder="Data scadenza" value="<%=(user.getExp_date() != null) ? user.getExp_date() : "" %>">
        </div>
        <hr class="section-divider">
        <div class="address">
            <h2 class="subsection-title">Indirizzo di fatturazione</h2>
            <label for="via" class="label">Nome della via e numero civico</label>
            <input form="CompleteOrderForm" name="via" id="via" class="input-button" type="text" placeholder="Indirizzo" value="<%=(user.getIndirizzo() != null) ? user.getIndirizzo() : "" %>">
            <label for="cap" class="label">CAP</label>
            <input form="CompleteOrderForm" name="cap" id="cap" type="text" class="input-button" placeholder="CAP" value="<%=(user.getCap() != 0) ? user.getCap() : "" %>">
            <label for="città" class="label">Città</label>
            <input form="CompleteOrderForm" name="città" id="città" type="text" placeholder="Città" class="input-button" value="<%=(user.getCitta() != null) ? user.getCitta() : "" %>">
        </div>
        <hr class="section-divider">
        <div class="riepilogo">
            <h2 class="subsection-title">Riepilogo ordine</h2>

            <div>
                <%for(i=0;i<carts.size();++i){%>
                    <div>
                        <p style="text-align: center; font-size: 1.3em; color: black; margin-bottom: 10px;" ><strong><%=carts.get(i).getProdotto().getNome_prod()%></strong></p>
                        <p style="text-align: center; font-size: 1.3em; color: black; margin-bottom: 10px;">Quantità: <%=carts.get(i).getQuantity()%></p>
                        <p style="text-align: center; font-size: 1.3em; color: #d63b18; margin-bottom: 10px;">Prezzo: <%=carts.get(i).getProdotto().getPrezzo()%></p>
                    </div>
                <%}%>

                <div>
                        <div>
                            <p style="text-align: center; font-size: 2em; color: black; margin-bottom: 10px;"><strong>Totale: </strong></p>
                        </div>
                        <div>
                            <p style="text-align: center; font-size: 2em; color: black; margin-bottom: 10px;"><strong><%=total_amount.setScale(2,RoundingMode.CEILING)%></strong> </p>
                        </div>
                </div>
            </div>

            <button onclick="CompleteOrder()" class="acquista">
                Acquista
            </button>
            <button type="submit" form="BackForm" class="annulla">
                Annulla
            </button>
        </div>
        <hr class="section-divider">

        <form name="CompleteOrderForm" id="CompleteOrderForm" action="Dispatcher" method="post">
            <input type="hidden" name="controllerAction" value="CheckoutManagement.order">
        </form>
        <form name="BackForm" id="BackForm" action="Dispatcher" method="post">
            <input type="hidden" name="controllerAction" value="HomeManagement.view">
        </form>
    </main>

<%@include file="/include/footer.inc"%>
</body>
</html>
