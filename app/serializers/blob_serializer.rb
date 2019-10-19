class BlobSerializer < ActiveModel::Serializer
  attributes :id, :filename, :path, :content_type, :byte_size, :created_at

  def path
    Rails.application.routes.url_helpers.rails_blob_path(object, only_path: true)
  end
end
