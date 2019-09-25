module Api
  class SessionsController < ::ApiController
    skip_before_action :authorize_request

    def create
      user = User.find_by_email(sign_in_params[:email])

      if user.present? && user.valid_password?(sign_in_params[:password])
        @current_user = user

        data = user.slice(:id).merge(exp: 30.minutes.from_now.to_i)
        token = JWT.encode(data, Rails.application.secrets.secret_key_base)

        render_created(token: token, student: user.as_json)
      else
        render_errors('email or password' => ['is invalid'])
      end
    end

    private

    def sign_in_params
      params.permit(:email, :password)
    end
  end
end