class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :files,
             :like_count, :unlike_count, :created_at, :updated_at

  attribute :classification, if: :user_classification?

  belongs_to :user, key: :student

  def files
    object.files.map do |file|
      BlobSerializer.new(file.blob).as_json
    end
  end

  def classification
    object.classifications.find_by(user_id: @instance_options[:user_id])
  end

  def user_classification?
    @instance_options[:user_id]
  end
end
