module Api
  class BansController < ::ApiController
    def create
      form = CreateBanForm.new(subscription_params)
      form.user_id = current_user.id

      if form.perform
        render_created(form.subscription, SubscriptionSerializer)
      else
        render_errors(form.errors)
      end
    end

    def destroy
      form = DeleteBanForm.new(subscription_id: params[:id])
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
