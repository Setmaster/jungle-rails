describe('Jungle App Add to Cart', () => {

    it('should visit the home page', () => {
        cy.visit('/');
    });

    it('should have products visible on the page', () => {
        cy.visit('/');
        cy.get('.products article').should('be.visible');
    });

    it('should increase cart count when a product is added', () => {

        // Set larger viewport to ensure cart add button is visible
        cy.viewport(1280, 720);
        cy.visit('/');

        // Verify the initial cart count
        cy.get('.nav-link').contains('My Cart').then(($cart) => {
            const initialCount = parseCartCount($cart.text());

            // Find the first product that is not sold out
            cy.get('.products article').not(':contains("Sold Out")').first().as('firstAvailableProduct');

            // Scroll the Add button into view and click it
            cy.get('@firstAvailableProduct').find('button').scrollIntoView().click();

            // Check that the cart count increased by 1
            cy.get('.nav-link').contains('My Cart').should(($cart) => {
                const newCount = parseCartCount($cart.text());
                expect(newCount).to.eq(initialCount + 1);
            });
        });
    });

    function parseCartCount(cartText) {
        const match = cartText.match(/My Cart \((\d+)\)/);
        return match ? parseInt(match[1], 10) : 0;
    }
});
