class Api::AuthController < ApplicationController

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JwtService.encode(user_id: user.id)

      render json: { token: token, user: user }
    else
      render json: { error: "Credenciais inválidas" }, status: :unauthorized
    end
  end

  def userAuth
    user = current_user
    render json: user
  end

  def logout
    head :ok
  end
end
