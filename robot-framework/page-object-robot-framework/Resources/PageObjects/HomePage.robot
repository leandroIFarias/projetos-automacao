*** Settings ***
Library    SeleniumLibrary
Library    String
Library    RPA.Windows

*** Variables ***
${HOME_URL}                 https://www.discourse.org/
${HOME_TITLE}                Discourse is the place to build civilized communities | Discourse - Civilized Discussion
${HOME_TOPMENU}              xpath=//h1[contains(.,'The powerful, open platform for communities of all kinds')]
${HOME_SUBMENU_RESOURCES}    xpath=//a[contains(@aria-haspopup,'true')]
${HOME_SUBMENU_DEMO}         xpath=//a[@href='https://try.discourse.org/'][contains(.,'Demo Sandbox')]

*** Keywords ***
Acessar a página home do site
    [Documentation]    Keyword que acessa a HOME do site ${HOME_URL}.
    Go To               ${HOME_URL}
    Wait Until Element Is Visible    ${HOME_TOPMENU}    15
    Title Should Be     ${HOME_TITLE}

Acessar a menu página RESOURCES
    [Documentation]    Keyword que acessa o menu RESOURCES.
    Click Link               ${HOME_SUBMENU_RESOURCES}

Acessar a sub página DEMO
    [Documentation]    Keyword que acessa o subMenu DEMO.
    Wait Until Element Is Visible    ${HOME_SUBMENU_DEMO}    15
    Click Link               ${HOME_SUBMENU_DEMO}
    Title Should Be     ${HOME_TITLE}
