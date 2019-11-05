module Seeds
  module SeedsHelper
    def self.generate_group(user, discipline)
      split = discipline.name.split('-')
      name = split[1] || split[0]

      group_params = {
        institution_id: discipline.course.institution.id,
        course_id: discipline.course.id,
        discipline_id: discipline.id,
        name: name.squish,
        description: 'Adicione uma descrição ao grupo'
      }

      form = CreateGroupForm.new(group_params)
      form.user = user
      form.save
      form.group
    end

    def self.generate_student
      name  = Faker::Name.name
      email = Faker::Internet.safe_email(name: name)
      Student.create(name: name, email: email, password: '123123')
    end

    def self.generate_performance(student, group)
      performance_attributes = {
        user_id: student.id,
        discipline_id: group.discipline.id,
        description: 'Nota',
        value: rand(70..100),
        max_value: 100
      }
      Performance.create(performance_attributes)
    end

    def self.generate_event(student, group)
      data = {
        title: 'Título',
        content: 'Conteúdo',
        date: Time.now.next_day(rand(0..15)),
        user_id: student.id,
        group_id: group.id
      }

      CreateEventForm.new(data).perform
    end

    def self.generate_post(student, group)
      data = {
        title: "Post",
        content: "Conteúdo",
        user_id: student.id,
        group_id: group.id
      }

      form = CreatePostForm.new(data)
      return unless form.perform

      rand(0..1).times { attach_file(form.post.reload) }
    end

    def self.generate_classification(user, post)
      data = {
        post_id: post.id,
        user_id: user.id,
        like: rand(0..3) > 1
      }
      CreatePostClassificationForm.new(data).perform
    end

    def self.attach_file(post)
      files = Dir.new(Rails.root.join('app', 'assets', 'images'))
                 .children
                 .select { |name| name.ends_with?('png') }

      file = files.sample
      path = Rails.root.join('app', 'assets', 'images', file)
      post.files.attach(io: File.open(path), filename: file)
    end
  end
end
