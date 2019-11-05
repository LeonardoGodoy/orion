module Seeds
  class LoadInstitutions
    def perform
      data = YAML.safe_load(path.read)

      data.each do |institution_data|
        code    = institution_data['code']
        name    = institution_data['name']
        courses = institution_data['courses']

        institution = Institution.find_or_create_by(name: "#{code} - #{name}")
        next if courses.blank?

        courses.each do |course_data|
          name = course_data
          institution.courses.find_or_create_by(name: name)
        end
      end
    end

    def path
      Rails.root.join('db', 'seeds', 'files', 'institutions.yml')
    end
  end
end
