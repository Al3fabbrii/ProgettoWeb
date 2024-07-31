<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 26/07/2024
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
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
        --color-text-brand-on-brand: var(--color-primitives-brand-100);
        --color-background-default-default: var(--color-primitives-white-1000);
        --color-border-brand-default: var(--color-primitives-brand-800);
        --color-border-default-default: var(--color-primitives-gray-300);
        --color-background-brand-hover: var(--color-primitives-brand-900);
        --color-primitives-gray-900: rgba(30, 30, 30, 1);
        --color-primitives-gray-400: rgba(179, 179, 179, 1);
        --color-primitives-brand-100: rgba(245, 245, 245, 1);
        --color-primitives-white-1000: rgba(255, 255, 255, 1);
        --color-primitives-white-400: rgba(255, 255, 255, 0.4);
        --color-primitives-brand-900: rgba(30, 30, 30, 1);
        --color-primitives-brand-800: rgba(44, 44, 44, 1);
        --color-primitives-gray-300: rgba(217, 217, 217, 1);
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
        --color-text-brand-on-brand: var(--color-primitives-brand-100);
        --color-background-default-default: var(--color-primitives-white-1000);
        --color-border-brand-default: var(--color-primitives-brand-800);
        --color-border-default-default: var(--color-primitives-gray-300);
        --color-background-brand-hover: var(--color-primitives-brand-900);
    }

    [data-color-mode="SDS-dark"] {
        --color-text-default-default: var(--color-primitives-white-1000);
        --color-text-default-tertiary: var(--color-primitives-white-400);
        --color-text-brand-on-brand: var(--color-primitives-brand-900);
        --color-background-default-default: var(--color-primitives-gray-900);
        --color-border-brand-default: var(--color-primitives-brand-100);
        --color-border-default-default: var(--color-primitives-gray-600);
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
        width: 885px;
        height: 658px;
        top: 112px;
        left: 292px;
        background-color: #b9c6d2;
        border-radius: 30px;
        border: 2px solid;
        border-color: #000000;
    }

    .desktop .overlap {
        position: absolute;
        width: 843px;
        height: 200px;
        top: 18px;
        left: 21px;
    }

    .desktop .frame {
        flex-direction: column;
        width: 843px;
        height: 111px;
        align-items: flex-start;
        top: 0;
        left: 0;
        display: flex;
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
        width: 100%;
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
        color: var(--color-text-default-tertiary);
        font-size: var(--single-line-body-base-font-size);
        letter-spacing: var(--single-line-body-base-letter-spacing);
        line-height: var(--single-line-body-base-line-height);
        font-style: var(--single-line-body-base-font-style);
        color: black;
    }

    .desktop .input-field-wrapper {
        flex-direction: column;
        width: 843px;
        height: 111px;
        align-items: flex-start;
        top: 89px;
        left: 0;
        display: flex;
        gap: 10px;
        padding: 10px;
        position: absolute;
    }

    .desktop .button {
        all: unset;
        box-sizing: border-box;
        display: flex;
        width: 843px;
        height: 54px;
        align-items: center;
        justify-content: center;
        gap: var(--size-space-200);
        padding: var(--size-space-300);
        position: absolute;
        top: 224px;
        background-color: #336699;
        border-radius: var(--size-radius-200);
        overflow: hidden;
        border: 1px solid;
        border-color: var(--color-border-brand-default);
    }

    .desktop .user {
        position: relative;
        width: 20px;
        height: 20px;
        color: white;
    }

    .desktop .div {
        all: unset;
        box-sizing: border-box;
        position: relative;
        width: fit-content;
        font-family: "Inter-Regular", Helvetica;
        font-weight: 400;
        color: var(--color-text-brand-on-brand);
        font-size: 24px;
        letter-spacing: 0;
        line-height: 24px;
        white-space: nowrap;
    }

    .desktop .button-2 {
        all: unset;
        box-sizing: border-box;
        display: flex;
        width: 323px;
        height: 54px;
        align-items: center;
        justify-content: center;
        gap: var(--size-space-200);
        padding: var(--size-space-300);
        position: absolute;
        top: 564px;
        left: 278px;
        background-color: #336699;
        border-radius: var(--size-radius-200);
        overflow: hidden;
        border: 1px solid;
        border-color: var(--color-border-brand-default);
    }

    .desktop .button-3 {
        all: unset;
        box-sizing: border-box;
        position: relative;
        width: fit-content;
        font-family: "Inter-Regular", Helvetica;
        font-weight: 400;
        color: var(--color-text-brand-on-brand);
        font-size: 20px;
        letter-spacing: 0;
        line-height: 20px;
        white-space: nowrap;
    }

    .desktop .div-wrapper {
        width: 342px;
        height: 40px;
        align-items: center;
        justify-content: center;
        top: 307px;
        left: 250px;
        display: flex;
        gap: 10px;
        padding: 10px;
        position: absolute;
    }

    .desktop .p {
        position: relative;
        width: fit-content;
        font-family: var(--single-line-body-base-font-family);
        font-weight: var(--single-line-body-base-font-weight);
        color: #000000;
        font-size: var(--single-line-body-base-font-size);
        letter-spacing: var(--single-line-body-base-letter-spacing);
        line-height: var(--single-line-body-base-line-height);
        white-space: nowrap;
        font-style: var(--single-line-body-base-font-style);
    }

</style>
<head>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="globals.css" />
</head>
<body>
<div class="desktop">
    <div class="overlap-group-wrapper">
        <div class="overlap-group">
            <div class="overlap">
                <form name="logonForm" action="Dispatcher" method="post">
                    <div class="frame">
                        <div class="input-field">
                            <label for="username" class="label">Utente</label>
                            <input type="text" placeholder="username" class="input" id="username"  name="username" maxlength="40" required>
                        </div>
                    </div>

                    <div class="input-field-wrapper">
                        <div class="input-field">
                            <label for="password" class="label">Password</label>
                            <input type="password" placeholder="password" class="input" id="password" name="password" maxlength="40" required>
                        </div>
                    </div>

                    <input type="hidden" name="controllerAction" value="HomeManagement.logon"/>
                    <button class="button"><input type="submit" class="div" value="Effettua il login"></button>
                </form>
                <button class="button-2"><p class="button-3" onclick="location.href='Dispatcher?controllerAction=HomeManagement.view' ">Annulla</p></button>
                <div class="div-wrapper"><p class="p">Non sei ancora registrato? <a href="Dispatcher?controllerAction=HomeManagement.registerView">Registrati qui</a></p></div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
