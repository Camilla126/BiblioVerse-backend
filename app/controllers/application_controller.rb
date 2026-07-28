class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def authenticate_user!
    header = request.headers["Authorization"]
    token = header&.split(" ")&.last

    decoded = token && Authentication::JwtService.decode(token)
    @current_user = decoded && User.find_by(id: decoded[:user_id])

    render json: { errors: [ "Não autorizado" ] }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end
end
