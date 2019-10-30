module Api
  class PostClassificationsController < ::ApiController
    before_action :set_post

    def create
      form = CreatePostClassificationForm.new(classification_params)
      form.user_id = current_user.id

      if form.perform
        render_created(form.classification, PostClassificationSerializer)
      else
        render_errors(form.errors)
      end
    end

    def destroy
      form = DeletePostClassificationForm.new
      form.user_id = current_user.id
      form.post_id = @post.id

      if form.perform
        render_success(form.classification, PostClassificationSerializer)
      else
        render_errors(form.errors)
      end
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def classification_params
      params.permit(:like, :post_id)
    end
  end
end
