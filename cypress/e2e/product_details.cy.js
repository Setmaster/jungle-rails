describe('Jungle App Product Details', () => {

    it('should visit the home page', () => {
        cy.visit('/');
    });

    it('There are products on the page', () => {
        cy.visit('/');
        cy.get('.products article').should('be.visible');
    });

    it('should navigate to the product detail page when a product is clicked', () => {
        cy.visit('/');

        cy.get('.products article').should('have.length.at.least', 1);

        cy.get('.products article').first().find('a').click();

        cy.url().should('include', '/products/');

        cy.get('h1').should('be.visible');
    });

});
