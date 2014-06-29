class AuthController < ApplicationController
  respond_to :json

  # POST /auth
  def token
    client = PseudoCMS::API::Client.new(auth_params)
    token = client.create_token(
      client_id: ENV['API_CLIENT_ID'],
      client_secret: ENV['API_CLIENT_SECRET']
    )

    render json: token
  end

  private

  def auth_params
    params.require(:user).permit(:email, :password)
  end
end
