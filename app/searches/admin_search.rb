class AdminSearch < Searchlight::Search
  def base_query
    Admin.all
  end

  def search_name
    query.where('name like :name', name: "%#{name}%")
  end
end
