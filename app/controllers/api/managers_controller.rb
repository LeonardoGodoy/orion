module Api
  class ManagersController < ::ApiController
    def create
      form = CreateManagerForm.new(subscription_params)
      form.user_id = current_user.id

      if form.perform
        render_created(form.subscription, SubscriptionSerializer)
      else
        render_errors(form.errors)
      end
    end

    def destroy
      form = DeleteManagerForm.new(subscription_id: params[:id])
      form.user_id = current_user.id

      if form.perform
        render_success(form.subscription, SubscriptionSerializer)
      else
        render_errors(form.errors)
      end
    end

    private

    def subscription_params
      params.permit(:subscription_id)
    end
  end
end
