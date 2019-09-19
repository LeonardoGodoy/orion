# To restore development enviroment run:
# rails db:drop db:create db:migrate db:seed

if Rails.env.development?
  User.create(name: 'Admin', email: 'admin@admin.com', password: '123123')
  User.create(name: 'User', email: 'user@user.com', password: '123123')

  20.times do
    name = Faker::Name.name
    email = Faker::Internet.safe_email(name: name)

    User.create(name: name, email: email, password: '123123')
  end

  50.times do
    institution = Institution.create(name: Faker::Educator.university)
    course = Course.create(name: Faker::Educator.course_name)
    discipline = Discipline.create(name: Faker::Educator.subject)
    group = Group.create(institution: institution, course: course, discipline: discipline)
  end
end