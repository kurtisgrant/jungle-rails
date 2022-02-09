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
      puts @user2.errors.full_messages.inspect
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
end