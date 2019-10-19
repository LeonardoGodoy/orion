class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :files, :created_at, :updated_at

  belongs_to :user, key: :student

  def files
    object.files.map do |file|
      BlobSerializer.new(file.blob).as_json
    end
  end
end
