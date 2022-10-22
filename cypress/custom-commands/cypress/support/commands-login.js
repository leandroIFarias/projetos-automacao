// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add('login', (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add('drag', { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add('dismiss', { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This will overwrite an existing command --
// Cypress.Commands.overwrite('visit', (originalFn, url, options) => { ... })

Cypress.Commands.add('loginSuccessfully', (username, password) => {
    cy.visit("/")
    cy.viewport(1280, 720);
    cy.clearCookie('saucedemo.com');
    cy.clearCookie('www.saucedemo.com');
    cy.screenshot('inpunt user');
    cy.get("input[id='user-name']").type(username)
    cy.get("input[id='password']").type(password)
    cy.screenshot('input password');
    cy.get("[data-test='login-button']").submit()
  })