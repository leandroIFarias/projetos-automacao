const { defineConfig } = require("cypress");

module.exports = defineConfig({
  chromeWebSecurity: false,
  e2e: {
    baseUrl: 'https://www.saucedemo.com/', 
    specPattern: "**/*.cy.js", // espefifica a localizacao dos arquivos de testes
    supportFile: "../support/e2e.js",
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});
