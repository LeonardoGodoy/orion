class EventSearch < Searchlight::Search
  def base_query
    Event.all
  end

  def search_title
    query.where('title like :title', title: "%#{title}%")
  end

  def search_group_id
    query.where(group_id: group_id)
  end

  def search_user_id
    query.where(user_id: user_id)
  end
end
