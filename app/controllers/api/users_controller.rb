module Api
  class UsersController < ::ApiController
    skip_before_action :authorize_request

    def create
      user = User.new(user_params)

      if user.valid? && user.save
        data = user.slice(:id).merge(exp: 1.minutes.from_now.to_i)
        token = JWT.encode(data, Rails.application.secrets.secret_key_base)

        render json: { token: token }
      else
        render json: { errors: user.errors.messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:name, :email, :password)
    end
  end
end