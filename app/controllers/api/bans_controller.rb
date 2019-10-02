module Api
  class BansController < ::ApiController
    def create
      form = BanForm.new(subscription_params)
      form.user_id = current_user.id
      form.banned = true

      if form.perform
        render_created(form.subscription, SubscriptionSerializer)
      else
        render_errors(form.errors)
      end
    end

    def destroy
      form = BanForm.new(subscription_id: params[:id])
      form.user_id = current_user.id
      form.banned = false

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
