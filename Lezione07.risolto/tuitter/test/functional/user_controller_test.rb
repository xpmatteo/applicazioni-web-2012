require 'test_helper'

class UserControllerTest < ActionController::TestCase
  
  setup do
    User.delete_all
    create_a_user!
  end
  
  
  # test "the truth" do
  #   assert true
  # end
end
