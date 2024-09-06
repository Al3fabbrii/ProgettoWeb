<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %>
<%@ page import="com.progettoweb.progettoweb.model.mo.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Date" %><%--
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
    String menuActiveLink="Visualizzazione ordine";

    List<Order> order_tuples=(List<Order>) request.getAttribute("order_tuples");

    boolean setCompleted=false;
    try{
        setCompleted=(Boolean) request.getAttribute("setDeliveredSwitch");
    }catch(NullPointerException e){}

    DateFormat dateFormatter= new SimpleDateFormat("yyyy-MM-dd");
    DateFormat timeFormatter= new SimpleDateFormat("HH:mm:ss");
    DateFormat formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
    <link href="https://fonts.cdnfonts.com/css/games" rel="stylesheet">

    <script>
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
        .subsection-title{
            font-size: 3em;
            color: black;
            text-align: center;
        }
        .item-title{
            font-size:2em;
            color: black;
            text-align: center;
        }
        .completed-button{
            display:flex;
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
        <h1 class="section-title">Ordine del <%=dateFormatter.format(order_tuples.get(0).getTimestamp())%> alle <%=timeFormatter.format(order_tuples.get(0).getTimestamp())%></h1>

        <%for(i=0;i<order_tuples.size();++i){%>
            <div>
                <h2 class="item-title"><%=order_tuples.get(i).getProduct().getNome_prod()%></h2>
                <p style="text-align: center; font-size: 1.5em; color: black; margin-bottom: 10px;">Quantità: <%=order_tuples.get(i).getQuantity()%></p>
                <p style="text-align: center; font-size: 1.5em; color: black; margin-bottom: 10px;">Prezzo: <%=order_tuples.get(i).getProduct().getPrezzo()%></p>
            </div>
        <%}%>

        <div>
            <h2 class="subsection-title">Stato dell'ordine</h2>
            <p style="text-align: center; font-size: 1.3em; color: black; margin-bottom: 10px;"><%=order_tuples.get(0).getStatus()%></p>
            <%if(!order_tuples.get(0).getStatus().equals("Ordine completato") || setCompleted){%>
                <button type="submit" form="setCompletedForm" id="deliver-button" class="completed-button">Marca come completato</button>
            <%}%>
        </div>


        <form name="setCompletedForm" id="setCompletedForm" action="Dispatcher" method="post">
            <input type="hidden" name="order_date" value="<%=order_tuples.get(0).getTimestamp().getTime()%>">
            <input type="hidden" name="controllerAction" value="OrderManagement.setCompleted">
        </form>
    </main>

<%@include file="/include/footer.inc"%>
</body>
</html>
