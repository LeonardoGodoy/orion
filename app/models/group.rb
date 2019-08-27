class Group < ApplicationRecord
  belongs_to :institution, optional: true
  belongs_to :course, optional: true
  belongs_to :discipline, optional: true
end
