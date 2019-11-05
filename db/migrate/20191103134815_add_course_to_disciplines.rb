class AddCourseToDisciplines < ActiveRecord::Migration[5.2]
  def change
    add_reference :disciplines, :course, foreign_key: true
  end
end
