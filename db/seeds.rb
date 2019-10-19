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

  def generate_group(user)
    institution = Institution.create(name: Faker::Educator.university)
    course      = Course.create(name: Faker::Educator.course_name)
    discipline  = Discipline.create(name: Faker::Educator.subject)

    group_params = {
      institution_id: institution.id,
      course_id: course.id,
      discipline_id: discipline.id,
      name: Faker::Team.name,
      description: '...'
    }

    form = CreateGroupForm.new(group_params)
    form.user = user
    form.save
  end

  40.times { generate_group(Student.all.sample) }
  4.times { generate_group(student) }
  6.times { SubscribeForm.new(group_id: Group.all.sample.id, user_id: student.id).perform }

  student.groups.each do |group|
    rand(2..5).times { |i| Performance.create(user_id: student.id, discipline_id: group.discipline.id, description: "Nota #{i + 1}", value: rand(33..100), max_value: 100) }
    rand(4..9).times { SubscribeForm.new(group_id: group, user_id: Student.all.sample.id).perform }
    rand(8..15).times { SubscribeForm.new(group_id: group.id, user_id: Student.where.not(id: student.id).sample.id).perform }

    rand(1..5).times do |i|
      data = {
        title: "Título #{i + 1}",
        content: "Conteúdo #{i + 1}",
        date: Time.now.next_day(rand(0..15)),
        user_id: Student.joins(:subscriptions).where(subscriptions: { group_id: group.id }).sample.id,
        group_id: group.id
      }

      CreateEventForm.new(data).perform
    end


    files = Dir.new(Rails.root.join('app', 'assets', 'images')).children.select { |name| name.ends_with?('png') }

    rand(2..12).times do |i|
      data = {
        title: "Post #{i + 1}",
        content: "Conteúdo #{i + 1}",
        user_id: Student.joins(:subscriptions).where(subscriptions: { group_id: group.id }).sample.id,
        group_id: group.id
      }

      form = CreatePostForm.new(data)
      if form.perform
        rand(0..2).times do
          file = files.sample
          path = Rails.root.join('app', 'assets', 'images', file)
          form.post
              .files
              .attach(io: File.open(path), filename: file)
        end
      else
        puts form.post.errors.messages
      end
    end
  end
end
