<%--
  Created by IntelliJ IDEA.
  User: alessandro
  Date: 02/09/24
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://fonts.cdnfonts.com/css/games" rel="stylesheet">

<style>
    .home{
        background-color: #336699;
        position:relative;
        float:right;
        padding: 5px;
        margin: 5px;
        border: 2px solid;
        border-color: white;
        border-radius: 20px;
        text-align: center;
        color: white;
    }
    .image{
        width:50px;
        height: 50px;
    }
    p{
        text-align: center;
        font-size: 2em;
        color: white;
    }
</style>
<header class="clearfix">
    <h1 class="logo" style="font-family: 'Games', sans-serif;
                            font-size:5.5em;
                            ">House of Games
    </h1>
    <p>Accesso eseguito come amministratore</p>

    <section>
        <button onclick="location.href='Dispatcher?controllerAction=HomeManagement.view' " class="home">
            <img src="https://www.svgrepo.com/show/526560/home.svg" class="image">
            <br>Torna alla home del sito
        </button>
        <button onclick="location.href='Dispatcher?controllerAction=AdminManagement.view'" class="home">
            <img src="https://www.svgrepo.com/show/501805/admin.svg" class="image">
            <br>Torna alla home di amministrazione
        </button>
    </section>

</header>


<form name="logoutForm" action="Dispatcher" method="post">
    <input type="hidden" name="controllerAction" value="HomeManagement.logout"/>
</form>