<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.progettoweb.progettoweb.model.mo.Utente" %>
<%@ page session="false" %>
<%
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Registration";
%>

<!DOCTYPE html>
<html>
<style>
    :root {
        --body-base-font-family: "Inter", Helvetica;
        --body-base-font-weight: 400;
        --body-base-font-size: 16px;
        --body-base-letter-spacing: 0px;
        --body-base-line-height: 139.9999976158142%;
        --body-base-font-style: normal;
        --single-line-body-base-font-family: "Inter", Helvetica;
        --single-line-body-base-font-weight: 400;
        --single-line-body-base-font-size: 16px;
        --single-line-body-base-letter-spacing: 0px;
        --single-line-body-base-line-height: 100%;
        --single-line-body-base-font-style: normal;
        --collection-1-color: rgba(255, 255, 255, 1);
        --color-text-default-default: var(--color-primitives-gray-900);
        --color-text-default-tertiary: var(--color-primitives-gray-400);
        --color-text-default-secondary: var(--color-primitives-gray-500);
        --color-text-brand-on-brand: var(--color-primitives-brand-100);
        --color-background-default-default: var(--color-primitives-white-1000);
        --color-border-default-default: var(--color-primitives-gray-300);
        --color-border-brand-default: var(--color-primitives-brand-800);
        --color-background-brand-hover: var(--color-primitives-brand-900);
        --color-primitives-gray-900: rgba(30, 30, 30, 1);
        --color-primitives-gray-400: rgba(179, 179, 179, 1);
        --color-primitives-gray-500: rgba(117, 117, 117, 1);
        --color-primitives-brand-100: rgba(245, 245, 245, 1);
        --color-primitives-white-1000: rgba(255, 255, 255, 1);
        --color-primitives-white-400: rgba(255, 255, 255, 0.4);
        --color-primitives-brand-900: rgba(30, 30, 30, 1);
        --color-primitives-white-500: rgba(255, 255, 255, 0.7);
        --color-primitives-gray-300: rgba(217, 217, 217, 1);
        --color-primitives-brand-800: rgba(44, 44, 44, 1);
        --color-primitives-gray-600: rgba(68, 68, 68, 1);
        --color-primitives-brand-300: rgba(217, 217, 217, 1);
        --size-space-400: 16px;
        --size-space-300: 12px;
        --size-space-200: 8px;
        --size-radius-200: 8px;
    }

    /*

    To enable a theme in your HTML, simply add one of the following data attributes to an HTML element, like so:

    <body data-color-mode="SDS-light">
        <!-- the rest of your content -->
    </body>

    You can apply the theme on any DOM node, not just the `body`

    */

    [data-color-mode="SDS-light"] {
        --color-text-default-default: var(--color-primitives-gray-900);
        --color-text-default-tertiary: var(--color-primitives-gray-400);
        --color-text-default-secondary: var(--color-primitives-gray-500);
        --color-text-brand-on-brand: var(--color-primitives-brand-100);
        --color-background-default-default: var(--color-primitives-white-1000);
        --color-border-default-default: var(--color-primitives-gray-300);
        --color-border-brand-default: var(--color-primitives-brand-800);
        --color-background-brand-hover: var(--color-primitives-brand-900);
    }

    [data-color-mode="SDS-dark"] {
        --color-text-default-default: var(--color-primitives-white-1000);
        --color-text-default-tertiary: var(--color-primitives-white-400);
        --color-text-default-secondary: var(--color-primitives-white-500);
        --color-text-brand-on-brand: var(--color-primitives-brand-900);
        --color-background-default-default: var(--color-primitives-gray-900);
        --color-border-default-default: var(--color-primitives-gray-600);
        --color-border-brand-default: var(--color-primitives-brand-100);
        --color-background-brand-hover: var(--color-primitives-brand-300);
    }

    .desktop {
        background-color: #ffffff;
        display: flex;
        flex-direction: row;
        justify-content: center;
        width: 100%;
    }

    .desktop .overlap-group-wrapper {
        background-color: #ffffff;
        width: 1440px;
        height: 1024px;
    }

    .desktop .overlap-group {
        position: relative;
        width: 840px;
        height: 800px;
        top: 112px;
        left: 300px;
        background-color: #b9c6d2;
        border-radius: 30px;
        border: 2px solid;
        border-color: #000000;
    }

    .desktop .overlap {
        position: absolute;
        width: 800px;
        height: 386px;
        top: 112px;
        left: 20px;
    }

    .desktop .frame {
        display: flex;
        flex-direction: column;
        width: 800px;
        height: 100px;
        align-items: flex-start;
        top: 193px;
        left: 0;
        gap: 10px;
        padding: 10px;
        position: absolute;
    }

    .desktop .input-field {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        gap: var(--size-space-200);
        position: relative;
        align-self: stretch;
        width: 95%;
        flex: 0 0 auto;
    }

    .desktop .label {
        position: relative;
        align-self: stretch;
        margin-top: -1px;
        font-family: var(--body-base-font-family);
        font-weight: var(--body-base-font-weight);
        color: var(--color-text-default-default);
        font-size: var(--body-base-font-size);
        letter-spacing: var(--body-base-letter-spacing);
        line-height: var(--body-base-line-height);
        font-style: var(--body-base-font-style);
        background: transparent;
        border: none;
        padding: 0;
    }

    .desktop .input {
        min-width: 240px;
        padding: var(--size-space-300) var(--size-space-400) var(--size-space-300) var(--size-space-400);
        position: relative;
        align-self: stretch;
        width: 95%;
        margin-bottom: -1px;
        margin-left: -1px;
        margin-right: -1px;
        background-color: var(--color-background-default-default);
        border-radius: var(--size-radius-200);
        overflow: hidden;
        border: 1px solid;
        border-color: var(--color-border-default-default);
        flex: 1;
        margin-top: -0.5px;
        font-family: var(--single-line-body-base-font-family);
        font-weight: var(--single-line-body-base-font-weight);
        color: black;
        font-size: var(--single-line-body-base-font-size);
        letter-spacing: var(--single-line-body-base-letter-spacing);
        line-height: var(--single-line-body-base-line-height);
        font-style: var(--single-line-body-base-font-style);
    }

    .desktop .input-field-wrapper {
        display: flex;
        flex-direction: column;
        width: 800px;
        height: 100px;
        align-items: flex-start;
        gap: 10px;
        padding: 10px;
        position: absolute;
        top: 286px;
        left: 0;
    }

    .desktop .div {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        gap: var(--size-space-200);
        position: relative;
        align-self: stretch;
        width: 95%;
        flex: 0 0 auto;
        margin-bottom: 0px;
    }

    .desktop .password-description {
        position: relative;
        align-self: stretch;
        font-family: var(--body-base-font-family);
        font-weight: var(--body-base-font-weight);
        color: var(--color-text-default-secondary);
        font-size: var(--body-base-font-size);
        letter-spacing: var(--body-base-letter-spacing);
        line-height: var(--body-base-line-height);
        font-style: var(--body-base-font-style);
        margin-top: 0px;
        margin-bottom: 0px;
    }

    .desktop .value {
        position: relative;
        flex: 1;
        margin-top: -0.5px;
        font-family: var(--single-line-body-base-font-family);
        font-weight: var(--single-line-body-base-font-weight);
        color: var(--color-text-default-tertiary);
        font-size: var(--single-line-body-base-font-size);
        letter-spacing: var(--single-line-body-base-letter-spacing);
        line-height: var(--single-line-body-base-line-height);
        font-style: var(--single-line-body-base-font-style);
    }

    .desktop .div-wrapper {
        display: flex;
        flex-direction: column;
        width: 800px;
        height: 100px;
        align-items: flex-start;
        top: 94px;
        left: 0;
        gap: 10px;
        padding: 10px;
        position: absolute;
    }

    .desktop .frame-2 {
        display: flex;
        flex-direction: column;
        width: 800px;
        height: 100px;
        align-items: flex-start;
        top: 0;
        left: 0;
        gap: 10px;
        padding: 10px;
        position: absolute;
    }

    .desktop .frame-3 {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        top: 632px;
        left: 291px;
        gap: 10px;
        padding: 10px;
        position: absolute;
    }

    .desktop .p {
        position: relative;
        width: fit-content;
        margin-top: -1px;
        font-family: var(--single-line-body-base-font-family);
        font-weight: var(--single-line-body-base-font-weight);
        color: #000000;
        font-size: var(--single-line-body-base-font-size);
        letter-spacing: var(--single-line-body-base-letter-spacing);
        line-height: var(--single-line-body-base-line-height);
        white-space: nowrap;
        font-style: var(--single-line-body-base-font-style);
    }

    .desktop .button {
        all: unset;
        box-sizing: border-box;
        display: flex;
        width: 278px;
        height: 76px;
        align-items: center;
        justify-content: center;
        gap: var(--size-space-200);
        padding: var(--size-space-300);
        position: absolute;
        top: 681px;
        left: 279px;
        background-color: #336699;
        border-radius: var(--size-radius-200);
        overflow: hidden;
        border: 1px solid;
        border-color: var(--color-border-brand-default);
    }

    .desktop .button-2 {
        all: unset;
        box-sizing: border-box;
        position: relative;
        width: fit-content;
        font-family: "Inter-Regular", Helvetica;
        font-weight: 400;
        color: var(--color-text-brand-on-brand);
        font-size: 32px;
        letter-spacing: 0;
        line-height: 32px;
        white-space: nowrap;
    }



    .desktop .button-3 {
        all: unset;
        box-sizing: border-box;
        display: flex;
        width: 800px;
        height: 48px;
        align-items: center;
        justify-content: center;
        gap: var(--size-space-200);
        padding: var(--size-space-300);
        position: absolute;
        top: 460px;
        left: 0px;
        background-color: #336699;
        border-radius: var(--size-radius-200);
        overflow: hidden;
        border: 1px solid;
        border-color: var(--color-border-brand-default);
    }

    .desktop .user {
        position: relative;
        width: 16px;
        height: 16px;
    }

    .desktop .button-4 {
        all: unset;
        box-sizing: border-box;
        position: relative;
        width: fit-content;
        margin-top: -1px;
        font-family: "Inter-Regular", Helvetica;
        font-weight: 400;
        color: var(--color-text-brand-on-brand);
        font-size: 24px;
        letter-spacing: 0;
        line-height: 24px;
        white-space: nowrap;
    }

    .desktop .frame-4 {
        display: flex;
        flex-direction: column;
        width: 800px;
        height: 100px;
        align-items: flex-start;
        top: -100px;
        left: 0px;
        gap: 10px;
        padding: 10px;
        position: absolute;
    }
</style>
<head>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="globals.css" />
    <title>Registrazione</title>
</head>
<body>
<div class="desktop">
    <div class="overlap-group-wrapper">
        <div class="overlap-group">
            <div class="overlap">

                <form name="registerForm" id="registerForm" action="Dispatcher" method="post">
                    <div class="frame-4">
                        <div class="input-field">
                            <label for="nome" class="label">Nome</label>
                            <input class="input" id="nome" name="nome" placeholder="nome" type="text" required/>
                        </div>
                    </div>
                    <div class="frame-2">
                        <div class="input-field">
                            <label for="cognome" class="label">Cognome:</label>
                            <input class="input" id="cognome" name="cognome" placeholder="cognome" type="text" required/>
                        </div>
                    </div>
                    <div class="div-wrapper">
                        <div class="input-field">
                            <label for="email" class="label">Email</label>
                            <input class="input" id="email" name="email" placeholder="email" type="email" required/>
                        </div>
                    </div>
                    <div class="frame">
                        <div class="input-field">
                            <label for="username" class="label">Username</label>
                            <input class="input" id="username" name="username" placeholder="username" type="text" required/>
                        </div>
                    </div>
                    <div class="input-field-wrapper">
                        <div class="div">
                            <label for="password" class="label">Password</label>
                            <p class="password-description">La password deve contenere almeno 8 caratteri, almeno 1 numero e 1 lettera maiuscola</p>
                            <input class="input" id="password" name="password" placeholder="password" type="password" required/>
                        </div>
                    </div>
                    <input type="hidden" name="controllerAction" value="HomeManagement.register"/>
                    <button class="button-3">
                        <input class="button-4" type="submit" value="Registrati">
                    </button>
                </form>

            </div>
            <div class="frame-3"><p class="p">Ti sei gi&agrave; registrato? <a href="Dispatcher?controllerAction=HomeManagement.loginView">Fai il login</a></p></div>
            <button class="button"><p class="button-2" onclick="location.href='Dispatcher?controllerAction=HomeManagement.view' ">Annulla</p></button>


        </div>
    </div>
</div>
</body>
</html>
