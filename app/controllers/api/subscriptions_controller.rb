module Api
  class SubscriptionsController < ::ApiController
    before_action :set_subscription, only: [:update]

    def index
      @subscriptions = SubscriptionSearch.new(search_params).results
      render_success_array(@subscriptions, SubscriptionSerializer)
    end

    def create
      form = SubscribeForm.new(subscription_params)
      form.user_id = current_user.id

      if form.perform
        render_created(form.subscription, SubscriptionSerializer)
      else
        render_errors(form.errors)
      end
    end

    def update
      if @subscription.update(subscription_params)
        render_success(@subscription, SubscriptionSerializer)
      else
        render_errors(@subscription.errors)
      end
    end

    def destroy
      form = UnsubscribeForm.new(subscription_id: params[:id])
      form.user_id = current_user.id

      if form.perform
        render_success(form.subscription, SubscriptionSerializer)
      else
        render_errors(form.errors)
      end
    end

    private

    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def search_params
      params.permit(:user_id, :group_id)
    end

    def subscription_params
      params.require(:subscription).permit(:group_id)
    end
  end
end
