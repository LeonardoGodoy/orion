class DisciplineSearch < Searchlight::Search
  def base_query
    Discipline.all
  end

  def search_name
    query.where('name like :name', name: "%#{name}%")
  end
end
