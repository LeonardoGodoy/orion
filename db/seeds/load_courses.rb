module Seeds
  class LoadCourses
    def perform
      data = YAML.safe_load(path.read)

      data.each do |courses_data|
        name    = courses_data['name']
        periods = courses_data['periods']

        course = Course.find_or_create_by(name: name)
        next if course.blank?

        periods.each do |_period, disciplines_data|
          # we can save the period in the future

          disciplines_data.each do |discipline_data|
            name = discipline_data['name']
            code = discipline_data['code']

            course.disciplines.create(name: "#{code} - #{name}")
          end
        end
      end
    end

    def path
      Rails.root.join('db', 'seeds', 'files', 'courses.yml')
    end
  end
end
