require "test_helper"

describe User do
  describe '::create' do
    it 'valid with unique email' do
      user = User.new email: 'example@email.com', password: 'asdasd'
      assert user.valid?, "valid user"
    end

    it 'NOT valid without email' do
      user = User.new password: 'asdasd'
      assert !user.valid?, "invalid user"
    end

    it 'NOT valid with non-unique email' do
      user = User.new email: 'zenon@szerman.pl', password: 'asdasd'
      assert !user.valid?, "invalid user"
    end
  end
end