class AdminSearch < Searchlight::Search
  def base_query
    Admin.all
  end

  def search_name
    query.where('name ilike :name', name: "%#{name}%")
  end
end
