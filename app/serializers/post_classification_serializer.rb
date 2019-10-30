class PostClassificationSerializer < ActiveModel::Serializer
  attributes :id, :like, :created_at, :updated_at

  belongs_to :post
end
