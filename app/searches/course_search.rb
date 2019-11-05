class CourseSearch < Searchlight::Search
  def base_query
    Course.all
  end

  def search_institution_id
    query.where(institution_id: institution_id)
  end

  def search_name
    query.where('name ilike :name', name: "%#{name}%")
  end
end
