module Api
  class StudentsController < ::ApiController
    skip_before_action :authorize_request

    def create
      student = Student.new(user_params)

      if student.valid? && student.save
        data = student.slice(:id).merge(exp: 30.minutes.from_now.to_i)
        token = JWT.encode(data, Rails.application.secrets.secret_key_base)

        render json: { token: token }
      else
        render json: { errors: student.errors.messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:name, :email, :password)
    end
  end
end