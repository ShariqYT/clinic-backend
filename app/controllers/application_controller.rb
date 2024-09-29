class ApplicationController < ActionController::API
  before_action :authenticate_user, except: [:create]

  def current_user
    @current_user ||= User.find(decoded_token[0]['user_id']) if decoded_token
  end

  def authenticate_user
    render json: { error: 'Not Authorized' }, status: :unauthorized unless current_user
  end

  private

  def authenticate_user
    token = request.headers['Authorization']&.split(' ')&.last
    begin
      decoded_token = JWT.decode(token, 'A%^jkh213^sh@hS')[0]
      @current_user = User.find(decoded_token['user_id'])
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end 

  def decoded_token
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ')[1]
      begin
        JWT.decode(token, 'A%^jkh213^sh@hS')
      rescue JWT::DecodeError
        nil
      end
    end
  end

end
