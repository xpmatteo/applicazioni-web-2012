require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  setup do
    User.delete_all
    User.create! :username => "foo", :email => "foo@bar", :id => 4, :password => "zot"
  end
  
  test "no post possible unless logged in" do
    post :create, :user_id => User.first.id
    assert_redirected_to "/sessions/new"    
  end
  
  test "logged in user can post" do
    session[:user_id] = User.first.id
    post :create, :user_id => User.first.id
    assert_redirected_to "/"
  end
  
  test "logged in user post as another user" do
    session[:user_id] = User.first.id
    post :create, :user_id => 12345
    assert_response :unauthorized
  end
  
end
