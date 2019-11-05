class DisciplineSearch < Searchlight::Search
  def base_query
    Discipline.all
  end

  def search_name
    query.where('name ilike :name', name: "%#{name}%")
  end
end
