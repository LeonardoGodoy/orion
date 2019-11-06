class ResetPasswordMailer < ApplicationMailer
  default from: 'Orion App <orion.app.ufpr@gmail.com>'
  layout 'mailer'

  def send_reset_link
    @student = params[:student]
    @token   = params[:token]

    mail(to: student.email, subject: 'Recupere sua senha.')
  end

  def reset_link
    "http://www.orionapp/reset?token=#{@token}"
  end
  helper_method :reset_link
end

# Ex
# ResetPasswordMailer.with(student: Student.first, token: 'aa').send_reset_link.deliver_now
