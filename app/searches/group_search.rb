class GroupSearch < Searchlight::Search
  def base_query
    Group.all
  end

  def search_name
    query.where('name like :name', name: "%#{name}%")
  end

  def search_institution_id
    query.where(institution_id: institution_id)
  end

  def search_course_id
    query.where(course_id: course_id)
  end

  def search_discipline_id
    query.where(discipline_id: discipline_id)
  end
end
