class AbsenceSearch < Searchlight::Search
  def base_query
    Absence.all
  end

  def search_user_id
    query.where(user_id: user_id)
  end

  def search_discipline_id
    query.where(discipline_id: discipline_id)
  end
end
