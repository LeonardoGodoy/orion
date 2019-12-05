class SessionsController < Devise::SessionsController
  def create
    super do |resource|
       unless resource.is_a?(Admin)
        sign_out

        redirect_to user_session_path, notice: "Acesso negado!"
        return
      end
    end
  end
end
