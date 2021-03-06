class GroupSearch < Searchlight::Search
  def base_query
    Group.all
  end

  def search_name
    query.where('name like :name', name: "%#{name}%")
  end

  def search_year
    query.where(year: year)
  end

  def search_exclude_privates
    exclude = ActiveRecord::Type::Boolean.new.cast(exclude_privates)
    exclude ? query.where(private_group: false) : query
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

  def search_user_id
    query.joins(:subscriptions)
         .where(subscriptions: { user_id: user_id, active: true })
         .distinct
  end
end
