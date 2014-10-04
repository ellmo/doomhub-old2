require 'test_helper'

describe Author do
  describe 'create' do
    it 'valid with unique name' do
      user = Author.new name: 'Sir Not Appearing In This Movie'
      user.valid?.must_equal true
      user.errors.must_be_empty
    end
  end

  describe '#login' do
    it 'returns name for login if there`s no user' do
      authors(:shaun).login.must_equal 'Shaun'
    end

    it 'refers to User`s login, even if it has a name' do
      authors(:ellmo).login.must_equal 'ellmo'
    end
  end
end