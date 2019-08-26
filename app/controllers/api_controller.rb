class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :authorize_request

  def authorize_request
    header       = request.headers['Authorization']
    access_token = header.split(' ').last if header

    begin
      hash = JWT.decode(access_token, Rails.application.secrets.secret_key_base)
      @current_user = User.find_by(id: hash.first['id'])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
