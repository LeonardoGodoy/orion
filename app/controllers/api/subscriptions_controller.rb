module Api
  class SubscriptionsController < ::ApiController
    before_action :set_course, only: [:update]

    def create
      @subscription = Subscription.new(subscription_params)

      if @subscription.save
        render json: @subscription, status: :ok
      else
        render json: @subscription.errors, status: :unprocessable_entity
      end
    end

    def update
      if @subscription.update(subscription_params)
        render json: @subscription, status: :ok
      else
        render json: @subscription.errors, status: :unprocessable_entity
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

    def subscription_params
      params.require(:subscription).permit(:group_id).tap do |hash|
        hash[:user_id] = current_user.id
      end
    end
  end
end