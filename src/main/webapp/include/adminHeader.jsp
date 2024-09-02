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
    }

</style>
<header class="clearfix">
    <h1 class="logo" style="font-family: 'Games', sans-serif;
                            font-size:5.5em;
                            ">House of Games
    </h1>
    <p>Accesso eseguito come amministratore</p>

    <section>
        <a href="javascript:HomeForm.submit()" class="home">Torna alla Home del sito
            <img src="https://www.svgrepo.com/show/526560/home.svg">
        </a>
        <a href="Dispatcher?controllerAction=AdminManagement.view" class="home">Vai alla Home dell'amministrazione</a>
    </section>

</header>
<form name="HomeForm" action="Dispatcher" method="post">
    <input type="hidden" name="controllerAction" value="HomeManagement.view"/>
</form>

<form name="logoutForm" action="Dispatcher" method="post">
    <input type="hidden" name="controllerAction" value="HomeManagement.logout"/>
</form>