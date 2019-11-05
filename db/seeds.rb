require_relative './seeds/load_institutions.rb'
require_relative './seeds/load_courses.rb'
require_relative './seeds/load_students.rb'
require_relative './seeds/seeds_helper.rb'
# To restore development enviroment run:
# rails db:drop db:create db:migrate db:seed

puts 'Loading institutions...'
Seeds::LoadInstitutions.new.perform
puts 'Loading courses...'
Seeds::LoadCourses.new.perform
puts 'Loading admin...'
Admin.create(name: 'Admin', email: 'admin@admin.com', password: '123123')
puts 'Loading students...'
@members ||= Seeds::LoadStudents.new.perform

if Rails.env.development?
  puts 'Generating random students...'
  15.times { Seeds::SeedsHelper.generate_student }

  puts 'Generating random groups...'
  Discipline.all.each do |discipline|
    Seeds::SeedsHelper.generate_group(Student.all.sample, discipline)
  end

  puts 'Subscribing members...'
  ['DS660', 'DS661', 'DS260', 'DS960', 'DS802', 'DS803', 'DS804', 'DS871', 'DS875'].each do |code|
    discipline = Discipline.find_by('name ilike :code', code: "#{code}%")
    group = discipline.groups.first

    @members.each do |member|
      form = SubscribeForm.new(group_id: group.id, user_id: member.id)
      form.perform
      rand(1..3).times { Seeds::SeedsHelper.generate_performance(member, group) }

      CreateManagerForm.new(subscription_id: form.subscription.id, user_id: group.subscriptions.managers.first.user_id).perform
    end

    rand(3..5).times { SubscribeForm.new(group_id: group.id, user_id: Student.all.sample.id).perform  }
  end

  puts 'Generating events...'
  Group.all.each do |group|
    rand(2..5).times { Seeds::SeedsHelper.generate_event(group.users.sample, group) }
  end

  puts 'Generating posts...'
  Group.all.each do |group|
    students = Student.joins(:subscriptions)
                      .where(subscriptions: { group_id: group.id })
    rand(3..6).times do
      Seeds::SeedsHelper.generate_post(students.sample, group)
    end
  end

  puts 'Generating classifications'
  Post.all.each do |post|
    students = post.group.users

    rand(2..6).times do
      Seeds::SeedsHelper.generate_classification(students.sample, post)
    end
  end
end
