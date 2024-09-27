<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %>
<%@ page import="com.progettoweb.progettoweb.model.mo.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.TreeMap" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %><%--

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
    String menuActiveLink="Elenco ordini";

    List<Order> order_tuples=(List<Order>) request.getAttribute("order_tuples");
    TreeMap<Timestamp, List<Order>> ordersBySingleOrder= new TreeMap<>(Collections.reverseOrder());
    for(Order order: order_tuples){
        Timestamp order_date=order.getTimestamp();
        if(!ordersBySingleOrder.containsKey(order_date)){
            ordersBySingleOrder.put(order_date, new ArrayList<Order>());
        }
        ordersBySingleOrder.get(order_date).add(order);
    }

    DecimalFormat df=new DecimalFormat("#.##");
    df.setRoundingMode(RoundingMode.FLOOR);
    DateFormat outputFormatter=new SimpleDateFormat("yyyy-MM-dd");
%>
<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
    <script>
        function orderViewFunc(order_date){
            f=document.orderViewForm;
            f.order_date.value=order_date;
            f.requestSubmit();
        }
        function mainOnLoadHandler(){}
    </script>

    <style>
        .order-image{
            width: 80px;
        }
        .section-title {
            text-align: center;
            font-size: 40px;
            margin-bottom: 10px;
            color: #0a3868;
            font-family: 'Games', sans serif;
            letter-spacing: 2px;
        }
        .order-list{
            display: flex;
            justify-content: space-evenly;
        }
        .order-item{
            border: 2px solid black;
            border-radius: 10px;
            padding:5px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<%@include file="/include/header.jsp"%>

    <main>
        <h1 class="section-title">Ordini effettuati</h1>

        <div class="order-list">
            <%if(!order_tuples.isEmpty()){%>

                    <%for(Timestamp k: ordersBySingleOrder.keySet()){%>
                        <div class="order-item">
                            <img src="https://www.svgrepo.com/show/529449/cart-check.svg" class="order-image">
                            <p style="color:black; text-align: center;">Ordine del:</p>
                            <a href="Javascript:orderViewFunc(<%=k.getTime()%>)"><%=outputFormatter.format(k)%></a>
                        </div>
                    <%}%>

            <%}else{%>
                <p>Nessun ordine effettuato</p>
            <%}%>
        </div>
    </main>

<form name="orderViewForm" method="post" action="Dispatcher">
    <input type="hidden" name="order_date">
    <input type="hidden" name="controllerAction" value="OrderManagement.orderView">
</form>
<%@include file="/include/footer.inc"%>
</body>
</html>
