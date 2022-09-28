export default class ProductsPage {
    path = "/inventory";
 
    // Create variables for element locators
    usernameInput = "input[id='user-name']";
    passwordInput = "input[id='password']";
    loginButton = "[data-test='login-button']";
 
    // Create independent methods to do actions on elements
    visitProducts(){
        cy.visit(this.path);
    }
 
    ValidadePageProducts(){
        cy.get('.title').contains('Products')
    }
}