module Api
  class PasswordsController < ::ApiController
    skip_before_action :authorize_request

    def recover
      student = Student.find_by(email: params[:email])

      if student.present?
        token = student.send(:set_reset_password_token)

        ResetPasswordMailer.with(student: student, token: token)
                           .send_reset_link
                           .deliver_now

        render json: {}, status: :ok
      else
        render_errors('Usuário não encontrado')
      end
    end

    # put
    def reset
      student = Student.reset_password_by_token(student_params)

      if student.present?
        render_success(student)
      else
        render_errors('Usuário não encontrado')
      end
    end

    private

    def student_params
      params.permit(:reset_password_token, :password)
    end
  end
end
