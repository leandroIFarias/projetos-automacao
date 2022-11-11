*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}      chrome


*** Keywords ***
#### Setup e Teardown
Abrir navegador
    [Documentation]    Keyword que abre o browser.

    Open Browser        about:blank   ${BROWSER}
    Maximize Browser Window

Fechar navegador
    [Documentation]    Keyword que fecha o browser.

    Close Browser