class StudentSearch < Searchlight::Search
  def base_query
    Student.all
  end

  def search_name
    query.where('name ilike :name', name: "%#{name}%")
  end
end
