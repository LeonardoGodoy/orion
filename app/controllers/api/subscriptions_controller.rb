module Api
  class SubscriptionsController < ::ApiController
    before_action :set_course, only: [:update]

    def index
      @subscriptions = SubscriptionSearch.new(search_params).results
      render_success_array(@subscriptions, SubscriptionSerializer)
    end

    def create
      @subscription = Subscription.new(subscription_params)

      if @subscription.save
        render_created(@subscription, SubscriptionSerializer)
      else
        render_errors(@subscription.errors)
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
      # change to inactive
      @subscription.destroy
      render json: {}, status: :ok
    end

    private

    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def search_params
      params.permit(:user_id, :group_id)
    end

    def subscription_params
      params.require(:subscription).permit(:group_id).tap do |hash|
        hash[:user_id] = current_user.id
      end
    end
  end
end