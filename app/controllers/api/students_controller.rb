module Api
  class StudentsController < ::ApiController
    skip_before_action :authorize_request

    def create
      student = Student.new(user_params)

      if student.save
        data = student.slice(:id).merge(exp: 30.minutes.from_now.to_i)
        token = JWT.encode(data, Rails.application.secrets.secret_key_base)

        render_created(token: token, student: student.as_json)
      else
        render_errors(student.errors)
      end
    end

    private

    def user_params
      params.permit(:name, :email, :password)
    end
  end
end