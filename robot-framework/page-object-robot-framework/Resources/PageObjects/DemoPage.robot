*** Settings ***
Library    SeleniumLibrary
Library    String
Library    ../../Library/testes.py
Library    RPA.Windows


*** Variables ***
${DEMO_TEXT_FOOTER}              xpath=//div[@class='footer-message ember-view'][contains(.,'There are no more latest topics.')]
${HOME_TITLE}    Discourse is the place to build civilized communities | Discourse - Civilized Discussion
${DEMO_TITLE}    Demo
${counterlockedTopic}    1


*** Keywords ***
Switch Pages Browser
    [Documentation]    Keyword que alterna de abas do browser para poder seguir com o fluxo.
    Title Should Be     ${HOME_TITLE}
    Switch Window    title:${HOME_TITLE}    
    Sleep    2
    Switch Window    title:${DEMO_TITLE}
    Title Should Be     ${DEMO_TITLE}

Scroll Down na pagina DEMO ate o final
    [Documentation]    Keyword que dá scroll até o final da página.

    ${bool_footer} =    Set Variable    False

    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)

    WHILE    ${bool_footer} != True    
        Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
        ${bool_presentValue}=  Run Keyword And Return Status    Element Should Be Visible   ${DEMO_TEXT_FOOTER}
        IF    ${bool_presentValue}
            Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
           ${bool_footer} =    Set Variable    True
        END
    END
    Wait Until Element Is Visible    ${DEMO_TEXT_FOOTER}    15
    Sleep    2



Imprimir o título de todos os tópicos fechados
    [Documentation]    Keyword que Imprimi o título de todos os tópicos fechados.
    

    ${qtdlockedTopic}     Execute Javascript    return document.querySelectorAll(".topic-statuses:has(.d-icon-lock) + a").length
    Log    A quantidade de tópicos bloqueados foi: ${qtdlockedTopic}

    FOR    ${counterlockedTopic}    IN RANGE    ${qtdlockedTopic}
        #IF    ${counterlockedTopic} == 0
        #    ${counterlockedTopic}    Evaluate    ${counterlockedTopic} +1
        #END
        ${namelockedTopic}     Execute Javascript    return document.querySelectorAll(".topic-statuses:has(.d-icon-lock) + a").item(${counterlockedTopic}).innerText
        Log    O tópico '${namelockedTopic}' está bloqueado.
    END


Imprimir a quantidade de itens de cada categoria e dos que não possuem categoria
    Sleep    1


Imprimir o título do tópico mais visualizado com o numero de visualizações
    [Documentation]    Keyword que Imprime o Nome do Topico mais visualizado com a quantidade de visualizações.

    ${numerViewsOld}    Set Variable    1
    ${counter}    Set Variable         0
    ${lengthTopics}    Set Variable    0
    ${counter_topic}    Set Variable    0

    ${lengthViews}    Execute Javascript    return document.querySelectorAll('[class*="number"]').length
 
    FOR    ${counter}    IN RANGE    ${lengthViews}
        ${divisao}    Evaluate    ${counter} % 2 == 0
        IF    ${counter} == 0
            ${nameViews}    Execute Javascript    return document.querySelectorAll('.number')[1].title
            ${numerViews} =     Regex Capturar Numero   ${nameViews}
        ELSE   
            IF    ${divisao} == False 
                ${nameViews}    Execute Javascript    return document.querySelectorAll('.number')[${counter}].title
                ${numerViews} =     Regex Capturar Numero   ${nameViews}
                ${lengthTopics}    Evaluate       ${lengthTopics} +1
            END
        END
        IF    ${numerViews} > ${numerViewsOld}
            ${numerViewsOld}   Set Variable    ${numerViews}
            ${counter_topic}    Set Variable    ${lengthTopics} -1
        END
    END
    
    ${MaiorTopicoVizualizado}    Execute Javascript    return document.querySelectorAll('[class*="title raw-link raw-topic-link"]')[${counter_topic}].innerHTML
    
    Log      A maior visualização foi do tópico '${MaiorTopicoVizualizado}' com ${numerViewsOld} vizualizações.



