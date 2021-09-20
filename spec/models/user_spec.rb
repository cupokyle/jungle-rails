require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do

    it "is valid user when given valid attributes" do
      @user = User.new(first_name: "Johnny", last_name: "Bravo", email: "johnnybravo@gmail.com", password: "pppppp", password_confirmation: "pppppp")
      expect(@user).to be_valid
    end

    it "is not valid user when first_name is empty" do
      @user = User.new(first_name: nil, last_name: "Bravo", email: "johnnybravo@gmail.com", password: "pppppp", password_confirmation: "pppppp")
      expect(@user).to_not be_valid
    end
    
    it "is not valid user when last_name is empty" do
      @user = User.new(first_name: "Johnny", last_name: nil, email: "johnnybravo@gmail.com", password: "pppppp", password_confirmation: "pppppp")
      expect(@user).to_not be_valid
    end
    
    it "is not valid user when email is empty" do
      @user = User.new(first_name: "Johnny", last_name: "Bravo", email: nil, password: "pppppp", password_confirmation: "pppppp")
      expect(@user).to_not be_valid
    end

    it "is not valid user when password is empty" do
      @user = User.new(first_name: "Johnny", last_name: "Bravo", email: "johnnybravo@gmail.com", password: nil, password_confirmation: "pppppp")
      expect(@user).to_not be_valid
    end

    it "is not valid user when password confirmation is empty" do
      @user = User.new(first_name: "Johnny", last_name: "Bravo", email: "johnnybravo@gmail.com", password: "pppppp", password_confirmation: nil)
      expect(@user).to_not be_valid
    end
    
    it "is not valid user when password and confirmation do not match" do
      @user = User.new(first_name: "Johnny", last_name: "Bravo", email: "johnnybravo@gmail.com", password: "pppppp", password_confirmation: "qqqqqq")
      expect(@user).to_not be_valid
    end

    it "is not valid user when email is the same as another user" do
      @user = User.new(first_name: "Johnny", last_name: "Bravo", email: "johnnybravo@gmail.com", password: "pppppp", password_confirmation: "pppppp")
      expect(@user).to be_valid
      @user.save!
      @user2 = User.new(first_name: "Johnny", last_name: "Bravo", email: "johnnyBRAVO@gMAIL.com", password: "pppppp", password_confirmation: "pppppp")
      expect(@user2).to_not be_valid
    end

    it "is not valid user when password is less than 6 characters" do
      @user = User.new(first_name: "Johnny", last_name: "Bravo", email: "johnnybravo@gmail.com", password: nil, password_confirmation: "ppp")
      expect(@user).to_not be_valid
    end
  end

    describe '.authenticate_with_credentials' do
      
      it 'should return user if authentication is succesful' do
        @user = User.new(first_name: 'Peter', last_name: 'Pan', email: 'peterpan@gmail.com', password: 'tinkerbell', password_confirmation: 'tinkerbell')
        @user.save
        expect(User.authenticate_with_credentials('peterpan@gmail.com', 'tinkerbell')).to eq(@user)
      end

      it 'should succesfully login a user session' do
        @user = User.create(first_name: 'Joey', last_name: 'Pan', email: 'joeypan@gmail.com', password: 'tinkerbonk', password_confirmation: 'tinkerbonk')
        expect(User.authenticate_with_credentials('joeypan@gmail.com', 'tinkerbonk')).to eq(@user)
      end

      it 'should not login/return nil if a user email is incorrect' do
        @user = User.create(first_name: 'Joey', last_name: 'Pan', email: 'joeypan@gmail.com', password: 'tinkerbonk', password_confirmation: 'tinkerbonk')
        expect(User.authenticate_with_credentials('chrispan@gmail.com', 'tinkerbonk')).to eq(nil)
      end

      it 'should not login/return nil if a user password is incorrect' do
        @user = User.create(first_name: 'Joey', last_name: 'Pan', email: 'joeypan@gmail.com', password: 'tinkerbonk', password_confirmation: 'tinkerbonk')
        expect(User.authenticate_with_credentials('joeypan@gmail.com', 'iforget')).to eq(nil)
      end

      it 'should succesfully login a user session even if whitespace is added on edge of email' do
        @user = User.create(first_name: 'Joey', last_name: 'Pan', email: 'joeypan@gmail.com', password: 'tinkerbonk', password_confirmation: 'tinkerbonk')
        expect(User.authenticate_with_credentials(' joeypan@gmail.com  ', 'tinkerbonk')).to eq(@user)
      end

      it 'should succesfully login a user session if they mis-case their typed email' do
        @user = User.create(first_name: 'Joey', last_name: 'Pan', email: 'joeypan@gmail.com', password: 'tinkerbonk', password_confirmation: 'tinkerbonk')
        expect(User.authenticate_with_credentials('JOEYPAN@gMAil.Com', 'tinkerbonk')).to eq(@user)
      end
      
    end

  
end
