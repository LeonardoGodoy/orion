class StudentSearch < Searchlight::Search
  def base_query
    Student.all
  end

  def search_name
    query.where('name like :name', name: "%#{name}%")
  end
end
