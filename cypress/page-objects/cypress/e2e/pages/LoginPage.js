export default class LoginPage {
    path = "/";
 
    // Create variables for element locators
    usernameInput = "input[id='user-name']";
    passwordInput = "input[id='password']";
    loginButton = "[data-test='login-button']";
 
    // Create independent methods to do actions on elements
    visitLogin(){
        cy.visit(this.path);
    }
 
    typeUsername(username){
        cy.get(this.usernameInput).type(username);
    }
 
    typePassword(password){
        cy.get(this.passwordInput).type(password, {log: false});
    }
 
    clickLogin(){
        cy.get(this.loginButton).click();
    }
}