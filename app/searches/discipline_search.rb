class DisciplineSearch < Searchlight::Search
  def base_query
    Discipline.all
  end

  def search_course_id
    query.where(course_id: course_id)
  end

  def search_name
    query.where('name ilike :name', name: "%#{name}%")
  end
end
