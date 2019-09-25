module RenderJsonConcern
  extend ActiveSupport::Concern

  included do
    respond_to :json

    def render_created(object, serializer=false)
      render json: object, serializer: serializer, status: :created
    end

    def render_success(object, serializer=false)
      render json: object, serializer: serializer, status: :ok
    end

    def render_success_array(object, serializer=nil, options={})
      render json: object, each_serializer: serializer, **options, status: :ok
    end

    def render_unauthorized(reason)
      render json: { errors: reason }, status: :unauthorized
    end

    def render_errors(object)
      render json: { errors: object }, status: :unprocessable_entity
    end

    def render_not_found
      render json: { errors: 'Resourse not found' }, status: :not_found
    end
  end
end