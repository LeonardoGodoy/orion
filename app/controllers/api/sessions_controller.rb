module Api
  class SessionsController < ::ApiController
    skip_before_action :authorize_request

    def create
      user = User.find_by_email(sign_in_params[:email])

      if user && user.valid_password?(sign_in_params[:password])
        @current_user = user

        data = user.slice(:id).merge(exp: 1.minutes.from_now.to_i)
        token = JWT.encode(data, Rails.application.secrets.secret_key_base)

        render json: { token: token }
      else
        render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
      end
    end

    private

    def sign_in_params
      params.permit(:email, :password)
    end
  end
end