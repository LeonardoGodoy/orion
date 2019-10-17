class InstitutionSearch < Searchlight::Search
  def base_query
    Institution.all
  end

  def search_name
    query.where('name ilike :name', name: "%#{name}%")
  end
end
