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
        background-image: url("https://img.uhdpaper.com/wallpaper/playstation-buttons-background-digital-art-98@0@i-thumb.jpg?dl");
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

    .desktop .overlap-group-2 {
        width: 804px;
        height: 145px;
        top: 43px;
        left: 550px;
        background-color: #4e9bdb;
        font-family: "Inter-Regular", Helvetica;
        text-align:left;
        color: black;
        font-size: 3em;
        letter-spacing: 0;
        line-height: normal;
        white-space: nowrap;
        border-radius: 40px;
        border: 2px solid;
        position: absolute;
        border-color: #000000;
    }


    ::placeholder{
        color:black;
    }
    .desktop .search-alt-svgrepo {
        position: relative;
        width: 70px;
        height: 71px;
        top: 70px;
        left:1250px;
        object-fit: cover;
    }
    .profile-container{
        position: relative;
        top: 100px;
        float:right;
        left: 70px;
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
            <div class="overlap">
                <img class="cart-shopping" src="https://www.svgrepo.com/show/533043/cart-shopping.svg" onclick="location.href='Dispatcher?controllerAction=CartManagement.view'"/>
            </div>
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

