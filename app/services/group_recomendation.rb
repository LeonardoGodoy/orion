class GroupRecomendation
  attr_reader :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  def perform
    serialized_groups
  end

  def results
    @results ||= execute_query.to_hash
  end

  def execute_query
    ActiveRecord::Base.connection.select_all(query)
  end

  def query
    ActiveRecord::Base.send(:sanitize_sql_array, [base_query, query_params])
  end

  def query_params
    { user_id: user_id }
  end

  def base_query_attempt
    'select us.group_id, count(*) as total
    from subscriptions s
        inner join groups g on s.group_id = g.id and s.user_id = :user_id
        inner join subscriptions gs on gs.group_id = g.id and gs.user_id != :user_id
        inner join subscriptions us on us.user_id = gs.user_id
            and us.group_id != gs.group_id
            and us.group_id != s.group_id
    where gs.group_id not in (select s1.group_id from subscriptions s1 where s1.user_id = :user_id)
    group by us.group_id
    order by total desc
    limit 10'
  end

  def base_query
    'select group_id, count(*) total
    from subscriptions
        inner join groups on subscriptions.group_id = groups.id
    where subscriptions.user_id in
      (
        select user_id from subscriptions s where s.group_id in
          (select s1.group_id from subscriptions s1 where s1.user_id = :user_id)
      )
      and groups.id not in
        (select s1.group_id from subscriptions s1 where s1.user_id = :user_id)
    group by group_id
    order by total desc
    limit 10'
  end

  def serialized_groups
    @serialized_groups ||= begin
      results.map do |row|
        group = groups_hash[row['group_id']]
        GroupSerializer.new(group, colleagues: row['total']).as_json
      end
    end
  end

  def groups_hash
    @groups_hash ||= begin
      groups.inject({}) { |hash, group| hash.merge(group.id => group) }
    end
  end

  def groups
    Group.where(id: results.pluck('group_id'))
  end
end
