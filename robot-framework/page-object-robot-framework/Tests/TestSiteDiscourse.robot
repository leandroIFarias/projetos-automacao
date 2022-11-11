*** Settings ***
Documentation        *Script Name*: TestSiteDiscourse\n\n
...                  *Test Case*: ExecParCollect\n\n
...                  *Covered scenarios*:
...                        - _Acessar site Discourse com sucesso e Capturar as informacoes de Titulos, Topicos e Views com sucess_
...                        - _Acessar o subMenu DEMO com sucesso_
...                        - _Capturar as informacoes de Titulos, Topicos e Views com sucesso_
...                  *Author*: leandroFarias 
Resource            ../Resources/ResourceExecution.robot
Resource            ../resources/PageObjects/HomePage.robot
Resource    ../Resources/PageObjects/DemoPage.robot
Suite Setup          Abrir navegador
#Suite Teardown       Fechar navegador

*** Test Case ***
Cenario 1: Acessar site Discourse com sucesso 
    Acessar a página home do site

Cenario 2: Acessar o subMenu DEMO com sucesso 
    HomePage.Acessar a menu página RESOURCES
    HomePage.Acessar a sub página DEMO
    Switch Pages Browser
    Scroll Down na pagina DEMO ate o final

Cenario 3: Capturar as informacoes de Titulos, Topicos e Views com sucesso
    Capturar Todos os Topicos Bloqueados
    Retornar o maior Tópico visualizado