class PerformanceSearch < Searchlight::Search
  def base_query
    Performance.all
  end

  def search_year
    query.where(year: year)
  end

  def search_user_id
    query.where(user_id: user_id)
  end

  def search_discipline_id
    query.where(discipline_id: discipline_id)
  end
end
