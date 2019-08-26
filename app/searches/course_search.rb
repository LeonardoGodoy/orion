class CourseSearch < Searchlight::Search
  def base_query
    Course.all
  end

  def search_name
    query.where('name like :name', name: "%#{name}%")
  end
end
