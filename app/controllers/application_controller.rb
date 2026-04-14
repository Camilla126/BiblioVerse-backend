class ApplicationController < ActionController::API

  def authenticate_user!
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    
    begin
      decoded = Authentication::JwtService.decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      render json: { errors: ['Não autorizado'] }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end