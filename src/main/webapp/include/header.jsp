<script>
    function headerOnLoadHandler() {
        var usernameTextField = document.querySelector("#username");
        var usernameTextFieldMsg = "Lo username \xE8 obbligatorio.";
        var passwordTextField = document.querySelector("#password");
        var passwordTextFieldMsg = "La password \xE8 obbligatoria.";

        if (usernameTextField != undefined && passwordTextField != undefined ) {
            usernameTextField.setCustomValidity(usernameTextFieldMsg);
            usernameTextField.addEventListener("change", function () {
                this.setCustomValidity(this.validity.valueMissing ? usernameTextFieldMsg : "");
            });
            passwordTextField.setCustomValidity(passwordTextFieldMsg);
            passwordTextField.addEventListener("change", function () {
                this.setCustomValidity(this.validity.valueMissing ? passwordTextFieldMsg : "");
            });
        }
    }

</script>
<link href="https://fonts.cdnfonts.com/css/games" rel="stylesheet">

<style>
    .desktop {
        background-color: #336699;
        display: flex;
        flex-direction: row;
        justify-content: center;
        width: 100%;
    }

    .desktop .div {
        background-image: url("https://m.media-amazon.com/images/I/71kDbxHyB4L.jpg");
        background-size:  100% 200%;
        background-position-y: -100px;
        width: 100%;
        height: 230px;
        position: relative;
        justify-content: center;
        align-items:center;
    }

    .desktop .overlap {
        width: 70px;
        height: 70px;
        top: 20px;
        background-color: #4e9bdb;
        float: right;
        border-radius: 35px;
        border: 3px solid;
        position: relative;
        border-color: #000000;
    }

    .desktop .cart-shopping {
        position: absolute;
        width: 50px;
        height: 50px;
        top: 8px;
        left: 7px;
        object-fit: cover;
    }

    .desktop .overlap-group {
        width: 70px;
        height: 70px;
        top: 20px;
        left: -15px;
        background-color: #4e9bdb;
        float: right;
        border-radius: 35px;
        border: 3px solid;
        position: relative;
        border-color: #000000;
    }

    .desktop .account-svgrepo-com {
        position: absolute;
        width: 50px;
        height: 50px;
        top: 7px;
        left: 7px;
        object-fit: cover;
    }
    .home-group{
        width: 70px;
        height: 70px;
        top: 20px;
        position:relative;
        float: right;
        left: -30px;
        background-color: #4e9bdb;
        border: 3px solid black;
        border-radius: 35px;
    }
    .image-home-button{
        position: absolute;
        width: 50px;
        height: 50px;
        object-fit: cover;
        top: 7px;
        left: 7px;
    }


    ::placeholder{
        color:black;
    }

    .profile-container{
        position: relative;
        width: 97%;
        top: 50px;
        display: flex;
        justify-content: right;
    }

    .admin{
        position: relative;
        float: right;
        padding: 5px;
        background-color: #336699;
        border: 2px solid;
        border-color: black;
        border-radius: 20px;
        text-align:center;
        font-family: "Inter-Regular", Helvetica;
        color:white;
        font-size: 1.2em;
        margin-left: 10px;
    }

    .logout{
        width: auto;
        height: 25px;
    }
</style>
<header class="clearfix">
    <h1 class="logo" style="font-family: 'Games', sans serif;
                            font-size:5.5em;
                            ">House of games shop</h1>

    <form name="logoutForm" action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="HomeManagement.logout"/>
    </form>

    <div class="desktop">

        <div class="div">
            <%if(loggedOn){%>
            <div class="overlap">
                <img class="cart-shopping" src="https://www.svgrepo.com/show/533043/cart-shopping.svg" onclick="location.href='Dispatcher?controllerAction=CartManagement.view'"/>
            </div>
            <%}%>
            <div class="overlap-group">
                <img class="account-svgrepo-com" src="https://www.svgrepo.com/show/453660/account.svg" onclick="location.href='Dispatcher?controllerAction=HomeManagement.loginView' "/>
            </div>
            <div class="home-group">
                <img class="image-home-button" src="https://www.svgrepo.com/show/526560/home.svg" onclick="location.href='Dispatcher?controllerAction=HomeManagement.view'">
            </div>


            <%if (loggedOn) {%>
            <div class="profile-container">
                <%if (loggedOn && loggedUser.getAdmin().equals("Y")){%>
                <button class="admin" onclick="location.href='Dispatcher?controllerAction=AdminManagement.view' ">Amministrazione</button>
                <% }%>
                <button class="admin" onclick="location.href='Dispatcher?controllerAction=OrderManagement.view' ">Ordini</button>

                <button class="admin"onclick="location.href='Dispatcher?controllerAction=UserProfile.view' ">Profilo</button>

                <a class="admin" href="javascript:logoutForm.submit()">
                    <img src="https://www.svgrepo.com/show/500948/off.svg" class="logout">
                </a>
            </div>

            <%} %>
        </div>
    </div>
</header>

