require 'test_helper'

describe Author do
  describe 'create' do
    it 'valid with unique name' do
      user = Author.new name: 'Sir Not Appearing In This Movie'
      user.valid?.must_equal true
      user.errors.must_be_empty
    end
  end
end