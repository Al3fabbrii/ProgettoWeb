<%@ page import="com.progettoweb.progettoweb.model.mo.Cart" %>
<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %>
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
    String menuActiveLink = "Carrello";
    List<Cart> carts=(List<Cart>) request.getAttribute("carts");

    BigDecimal total_amount=(BigDecimal) request.getAttribute("total_amount");
%>
<html>
<head>
    <%@include file="/include/htmlHead.inc"%>

    <script>
        function AddToCart(id_prod){
            document.AddToCartForm.id_prod.value=id_prod;
            document.AddToCartForm.requestSubmit();
        }

        function RemoveFromCart(id_prod){
            document.RemoveFromCartForm.id_prod.value=id_prod;
            document.RemoveFromCartForm.requestSubmit();
        }

        function RemoveBlockFromCart(id_prod){
            document.RemoveBlock.id_prod.value=id_prod;
            document.RemoveBlock.requestSubmit();
        }

        function deleteCart(){
            document.DeleteCart.requestSubmit();
        }

        function mainOnLoadHandler(){}
    </script>

    <style>
        .cart-container{
            width: 90%;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin:auto;
        }
        .cart-item{
            width: 30%;
            border: 2px solid black;
            border-radius: 15px;
            margin: 10px;
        }
        .item-image{
            max-width: 70%;
            display:flex;
            margin:auto;
        }
        .item-name{
            text-align: center;
            font-size: 2em;
            color: black;
        }
        .item-price{
            text-align: center;
            font-size: 1.2em;
            color: #d63b18;
        }
        .item-actions{
            display: flex;
            justify-content: center;

        }
        .less-button{
            background-color: #4e9bdb;
            border: 2px solid;
            border-radius: 5px;
            position: relative;
            float: left;
            margin: 5px;
        }
        .add-button{
            background-color: #4e9bdb;
            border: 2px solid;
            border-radius: 5px;
            position: relative;
            float: left;
            margin: 5px;
        }
        .remove-button{
            background-color: #4e9bdb;
            border: 2px solid black;
            color: white;
            border-radius: 5px;
            position: relative;
            float: left;
            margin: 5px;
        }
        .less-image{
            max-width: 25px;
            position: relative;
            float: left;
        }
        .add-image{
            max-width: 25px;
            position: relative;
            float: left;
        }
        .trash-image{
            max-width: 25px;
        }

        .total{
            text-align: center;
            color: black;
            font-size: 2em;
        }
        .cart-buttons{
            display: flex;
            justify-content: center;
        }
        .confirm-button{
            border: 2px solid black;
            border-radius: 10px;
            background-color: #336699;
            color: white;
            font-size: 1.5em;
            max-width: 20%;
            position: relative;
            float: right;
            margin: 5px;
        }
        .delete-button{
            border: 2px solid black;
            border-radius: 10px;
            background-color: #336699;
            color: white;
            font-size: 1.5em;
            max-width: 20%;
            position: relative;
            float: right;
            margin: 5px;
        }
        .section-title {
            text-align: center;
            font-size: 40px;
            margin-bottom: 10px;
            color: #0a3868;
            font-family: 'Games', sans serif;
            letter-spacing: 2px;
        }
    </style>
</head>
<body>
<%@include file="/include/header.jsp"%>
    <main>
        <h1 class="section-title">Il tuo carrello</h1>

        <div class="cart-container">
            <%for(i=0;i<carts.size();++i){%>
                <div class="cart-item">
                    <img src="<%=carts.get(i).getProdotto().getImg_path()%>" class="item-image">
                    <div>
                        <div class="item-name"><%=carts.get(i).getProdotto().getNome_prod()%></div>
                        <div class="item-price">Prezzo: <%=carts.get(i).getProdotto().getPrezzo()%></div>
                    </div>

                    <div class="item-actions">
                        <button class="less-button" onclick="RemoveFromCart(<%=carts.get(i).getProdotto().getId_prod()%>)">
                            <img src="https://www.svgrepo.com/show/522184/minus.svg" class="less-image">
                        </button>
                        <p style="text-align: center; color: black;"><%=carts.get(i).getQuantity()%></p>
                        <button class="add-button" onclick="AddToCart(<%=carts.get(i).getProdotto().getId_prod()%>)">
                            <img src="https://www.svgrepo.com/show/522234/plus.svg" class="add-image">
                        </button>

                        <button class="remove-button" onclick="RemoveBlockFromCart(<%=carts.get(i).getProdotto().getId_prod()%>)">
                            <img src="https://www.svgrepo.com/show/533010/trash-alt.svg" class="trash-image">
                            <br >Rimuovi il prodotto dal carrello
                        </button>
                    </div>
                </div>
            <%}%>
        </div>

        <%if(total_amount.compareTo(BigDecimal.ZERO)!=0){%>
            <div>
                <div class="total">
                    <p>Totale: (comprensivo di IVA)</p>
                    <p><%=total_amount.setScale(2, RoundingMode.CEILING)%> €</p>
                </div>
            </div>

            <div class="cart-buttons">
                <button type="submit" form="CheckoutForm" class="confirm-button">
                    Vai al pagamento
                </button>

                <button class="delete-button" onclick="deleteCart()" type="submit">
                    Svuota il carrello
                </button>
            </div>
        <%} else {%>
            <div>
                <p style="text-align: center; color: black; font-size: 2.5em;">Il carrello è vuoto, torna alla home e seleziona almeno un gioco da acquistare</p>
            </div>
        <%}%>

        <form name="AddToCartForm" method="post" action="Dispatcher">
            <input type="hidden" name="id_prod">
            <input type="hidden" name="controllerAction" value="CartManagement.AddProduct">
            <input type="hidden" name="viewUrl" value="cartManagement/view">
        </form>
        <form name="RemoveFromCartForm" method="post" action="Dispatcher">
            <input type="hidden" name="id_prod">
            <input type="hidden" name="controllerAction" value="CartManagement.RemoveProduct">
            <input type="hidden" name="viewUrl" value="cartManagement/view">
        </form>
        <form name="RemoveBlock" method="post" action="Dispatcher">
            <input type="hidden" name="id_prod">
            <input type="hidden" name="controllerAction" value="CartManagement.RemoveProductBlock">
            <input type="hidden" name="viewUrl" value="cartManagement/view">
        </form>
        <form name="DeleteCart" method="post" action="Dispatcher">
            <input type="hidden" name="id_prod">
            <input type="hidden" name="controllerAction" value="CartManagement.DeleteCart">
            <input type="hidden" name="viewUrl" value="cartManagement/view">
        </form>
        <form name="CheckoutForm" id="CheckoutForm" method="post" action="Dispatcher">
            <input type="hidden" name="cart_id">
            <input type="hidden" name="controllerAction" value="CheckoutManagement.view">
        </form>
    </main>

<%@include file="/include/footer.inc"%>

</body>
</html>
