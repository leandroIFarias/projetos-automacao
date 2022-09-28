import LoginPage from '../pages/LoginPage';
import ProductsPage from '../pages/ProductsPage';
import testdata from '../../fixtures/testdata.json';

const loginPage = new LoginPage();
const productsPage = new ProductsPage();

describe('Login Test', () => {
  before(function () {
    loginPage.visitLogin();
    cy.viewport(1280, 720);

    // especificamente para esse site houve a necessidade de limpar o chache
    cy.clearCookie('saucedemo.com');
    cy.clearCookie('www.saucedemo.com');
})

  it('Login successfully', () => {
    cy.screenshot('inpunt user');
    loginPage.typeUsername(testdata.username);
    loginPage.typePassword(testdata.password);
    cy.screenshot('input password');
    loginPage.clickLogin();
    productsPage.ValidadePageProducts();
    cy.screenshot('Validade page products');
  })
})