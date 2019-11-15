class SubscriptionsController < ApplicationController
  before_action :set_subscription

  def activate
    if @subscription.update(active: true, banned: false)
      redirect_to student_path(@subscription.user.id), notice: 'Subscriptions was successfully activated.'
    else
      redirect_to student_path(@subscription.user.id)
    end
  end

  def inactivate
    if @subscription.update(active: false)
      redirect_to student_path(@subscription.user.id), notice: 'Subscriptions was successfully inactivated.'
    else
      redirect_to student_path(@subscription.user.id)
    end
  end

  def ban
    if @subscription.update(active: false, banned: true)
      redirect_to student_path(@subscription.user.id), notice: 'Subscriptions was successfully banned.'
    else
      redirect_to student_path(@subscription.user.id)
    end
  end

  def unban
    if @subscription.update(active: true, banned: false)
      redirect_to student_path(@subscription.user.id), notice: 'Subscriptions was successfully unbanned.'
    else
      redirect_to student_path(@subscription.user.id)
    end
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
