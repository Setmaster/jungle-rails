require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create(name: 'Test Category')
    end

    it 'is valid with valid attributes' do
      product = Product.new(
        name: 'Test Product',
        price_cents: 1000,
        quantity: 10,
        category: @category
      )
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product = Product.new(
        name: nil,
        price_cents: 1000,
        quantity: 10,
        category: @category
      )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a price' do
      product = Product.new(
        name: 'Test Product',
        price_cents: nil,
        quantity: 10,
        category: @category
      )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'is not valid without a quantity' do
      product = Product.new(
        name: 'Test Product',
        price_cents: 1000,
        quantity: nil,
        category: @category
      )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is not valid without a category' do
      product = Product.new(
        name: 'Test Product',
        price_cents: 1000,
        quantity: 10,
        category: nil
      )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
