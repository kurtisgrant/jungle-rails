require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    before do
      @user = User.create(name: 'R.L. Stine', email: 'test@testing.com', password: 'bestpass', password_confirmation: 'bestpass')
    end

    it 'should save user with all required fields' do
      saved = @user.save
      expect(saved).to be true
    end

    it 'should not save a second user with same email' do
      @user.save
      @user2 = User.create(name: 'R.R.L. Stine', email: 'test@testing.com', password: 'bestpass', password_confirmation: 'bestpass')
      @user2
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not save user with a 4 character password' do
      @user.password = 'pass'
      @user.password_confirmation = 'pass'
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'should not save user missing a name' do
      @user.name = nil
      @user.save
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not save user missing a password' do
      @user.password = nil
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not save user missing a password confirmation' do
      @user.password_confirmation = nil
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should not save user with mismatched passwords' do
      @user.password_confirmation = 'bestpast'
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

  end

  describe '.authenticate_with_credentials' do
    before do
      @email = 'example@example.com'
      @password = 'password!'
      @user = User.create(
        name: 'Jessica Exampleson', 
        email: @email, 
        password: @password, 
        password_confirmation: @password
      )
    end

    it 'should not authenticate user with incorrect email' do
      email = 'jess@example.com'
      auth = User.authenticate_with_credentials(email, @password)
      expect(auth).to eq nil
    end

    it 'should not authenticate user with incorrect password' do
      password = 'password?'
      auth = User.authenticate_with_credentials(@email, password)
      expect(auth).to eq nil
    end

    it 'should authenticate user with correct email & password' do
      auth = User.authenticate_with_credentials(@email, @password)
      expect(auth).to eq @user
    end

    it 'should authenticate user with space before email' do
      email_with_space = ' ' + @email
      auth = User.authenticate_with_credentials(email_with_space, @password)
      expect(auth).to eq @user
    end

    it 'should authenticate user with incorrect email case' do
      email_uppercase = @email.upcase
      auth = User.authenticate_with_credentials(email_uppercase, @password)
      expect(auth).to eq @user
    end

  end

end