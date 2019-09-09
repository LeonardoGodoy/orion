class UserSearch < Searchlight::Search
  def base_query
    User.all
  end

  def search_name
    query.where('name like :name', name: "%#{name}%")
  end
end
