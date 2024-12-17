require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with valid attributes' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end

    it 'is not valid without a first name' do
      user = User.new(last_name: 'Doe', email: 'john.doe@example.com', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
    end

    it 'is not valid without a last name' do
      user = User.new(first_name: 'John', email: 'john.doe@example.com', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(first_name: 'John', last_name: 'Doe', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email (case insensitive)' do
      User.create(first_name: 'Jane', last_name: 'Doe', email: 'john.doe@example.com', password: 'password', password_confirmation: 'password')
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'JOHN.DOE@EXAMPLE.COM', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com')
      expect(user).not_to be_valid
    end

    it 'is not valid without a password confirmation' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com', password: 'password')
      expect(user).not_to be_valid
    end

    it 'is not valid when password and password_confirmation do not match' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com', password: 'password', password_confirmation: 'different')
      expect(user).not_to be_valid
    end

    it 'is not valid with a password less than 6 characters' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com', password: 'short', password_confirmation: 'short')
      expect(user).not_to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com', password: 'password', password_confirmation: 'password')
    end

    it 'authenticates with correct credentials' do
      authenticated_user = User.authenticate_with_credentials('john.doe@example.com', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'does not authenticate with incorrect password' do
      authenticated_user = User.authenticate_with_credentials('john.doe@example.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    it 'authenticates despite leading/trailing spaces in email' do
      authenticated_user = User.authenticate_with_credentials('  john.doe@example.com  ', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'authenticates with email in different case' do
      authenticated_user = User.authenticate_with_credentials('JOHN.DOE@EXAMPLE.COM', 'password')
      expect(authenticated_user).to eq(@user)
    end
  end
end
