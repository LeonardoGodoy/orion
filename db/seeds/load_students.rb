module Seeds
  class LoadStudents
    def perform
      data = YAML.safe_load(path.read)

      data.map do |users_data|
        name     = users_data['name']
        email    = users_data['email']

        attributes = {
          name: name,
          email: email
        }

        Student.find_by(attributes) ||
          Student.create(attributes.merge(password: '123123'))
      end
    end

    def path
      Rails.root.join('db', 'seeds', 'files', 'students.yml')
    end
  end
end
