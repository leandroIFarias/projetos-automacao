export default class ProductsPage {
    path = "/inventory";
 
    // Create independent methods to do actions on elements
    visitProducts(){
        cy.visit(this.path);
    }
 
    ValidadePageProducts(){
        cy.get('.title').contains('Products')
    }
}