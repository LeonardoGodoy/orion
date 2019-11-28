module Api
  class BlobsController < ::ApiController
    include ActiveStorage::Downloading

    skip_before_action :authorize_request
    before_action :set_blob

    def download
      path = ActiveStorage::Blob.service.send(:path_for, @blob.key)

      send_file path,
                filename: @blob.filename.to_s,
                type: @blob.content_type,
                disposition: 'attachment'
    end

    def set_blob
      @blob ||= ActiveStorage::Blob.find(params[:id])
    end
  end
end
