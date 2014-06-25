require "test_helper"

describe User do
  describe 'create' do
    it 'valid with unique email and login' do
      user = User.new email: 'example@email.com', password: 'asdasd', login: 'qwerty'
      user.valid?.must_equal true
      user.errors.must_be_empty
    end

    describe 'email validations' do
      it 'NOT valid without email' do
        user = User.new password: 'asdasd', login: 'qwerty'
        user.valid?.wont_equal true
        user.errors.must_include :email
      end

      it 'NOT valid with non-unique email' do
        user = User.new email: 'zenon@szerman.pl', password: 'asdasd', login: 'qwerty'
        user.valid?.wont_equal true
        user.errors.must_include :email
      end
    end

    describe 'login validations' do
      it 'NOT valid without login' do
        user = User.new password: 'asdasd', email: 'example@email.com'
        user.valid?.wont_equal true
        user.errors.must_include :login
      end

      it 'NOT valid with non-unique login' do
        user = User.new email: 'example@email.com', password: 'asdasd', login: 'zenon'
        user.valid?.wont_equal true
        user.errors.must_include :login
      end
    end

    describe 'password validations' do
      it 'NOT valid without password' do
        user = User.new email: 'example@email.com', login: 'qwerty'
        user.valid?.wont_equal true
        user.errors.must_include :password
      end

      it 'NOT valid with password shorder than 3 chars' do
        user = User.new email: 'example@email.com', password: 'as', login: 'qwerty'
        user.valid?.wont_equal true
        user.errors.must_include :password
      end
    end
  end

  describe 'destroy' do
    let(:user){ users(:zenon) }
    before do
      user.destroy
    end

    it 'doesnt get deleted completely' do
      user.destroyed?.must_equal true
      User.all.wont_include user
      User.deleted.must_include user
    end

    it 'can be restored' do
      user.restore
      User.all.must_include user
      User.deleted.wont_include user
    end
  end
end