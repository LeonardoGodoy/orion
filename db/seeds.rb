# To restore development enviroment run:
# rails db:drop db:create db:migrate db:seed

if Rails.env.development?
  admin   = Admin.create(name: 'Admin', email: 'admin@admin.com', password: '123123')
  student = Student.create(name: 'User', email: 'user@user.com', password: '123123')

  50.times do
    name  = Faker::Name.name
    email = Faker::Internet.safe_email(name: name)
    Student.create(name: name, email: email, password: '123123')
  end

  20.times do
    institution = Institution.create(name: Faker::Educator.university)
    course      = Course.create(name: Faker::Educator.course_name)
    discipline  = Discipline.create(name: Faker::Educator.subject)

    group_params = {
      institution_id: institution.id,
      course_id:      course.id,
      discipline_id:  discipline.id,
      name:           Faker::Team.name
    }

    form = CreateGroupForm.new(group_params)
    form.user = Student.all.sample
    form.save
  end

  student.groups.each do |group|
    10.times do
      Subscription.create(user: Student.all.sample, group: group, manager: false)
    end
  end
end
