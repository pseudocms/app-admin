require 'test_helper'

class AuthControllerTest < ActionController::TestCase

  test "POST token with valid credentials returns access_token" do
    stub_api_method(create_token: successful_response)
    post :token, user_params(email: 'email@email.com', password: 'somethingValid')

    assert_response :success
    assert_match /access_token/, response.body
  end

  test "POST token with invalid credentials returns error" do
    stub_api_method(create_token: OpenStruct.new(error: ''))
    post :token, user_params(email: 'email@email.com', password: 'somethingInvalid')

    assert_response :success
    assert_match /error/, response.body
  end

  private

  def stub_api_method(stubs)
    PseudoCMS::API::Client.any_instance.stubs(stubs)
  end

  def user_params(properties)
    { user: properties }
  end

  def successful_response
    OpenStruct.new({
      access_token: '98798yjbjbkj',
      token_type: 'bearer',
      expires_in: 7200
    })
  end
end
