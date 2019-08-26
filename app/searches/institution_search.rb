class InstitutionSearch < Searchlight::Search
  def base_query
    Institution.all
  end

  def search_name
    query.where('name like :name', name: "%#{name}%")
  end
end
