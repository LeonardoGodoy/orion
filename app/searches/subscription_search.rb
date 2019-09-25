class SubscriptionSearch < Searchlight::Search
  def base_query
    Subscription.all
  end

  def search_group_id
    query.where(group_id: group_id)
  end

  def search_user_id
    query.where(user_id: user_id)
  end
end
