module Api
  class PostsController < ::ApiController
    before_action :set_post, only: [:show]

    def index
      @posts = PostSearch.new(search_params).results
      render_success_array(@posts, PostSerializer, user_id: current_user.id)
    end

    def show
      render_success(@post, PostSerializer)
    end

    def create
      form = CreatePostForm.new(post_params)
      form.user_id = current_user.id

      if form.perform
        render_created(form.post, PostSerializer)
      else
        render_errors(form.errors)
      end
    end

    def update
      form = UpdatePostForm.new(update_post_params)
      form.user_id = current_user.id
      form.post_id = params[:id]

      if form.perform
        render_success(form.post, PostSerializer)
      else
        render_errors(form.errors)
      end
    end

    def destroy
      form = DeletePostForm.new(post_id: params[:id])
      form.user_id = current_user.id

      if form.perform
        render_success(form.post, PostSerializer)
      else
        render_errors(form.errors)
      end
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def search_params
      params.permit(:title, :group_id, :user_id)
    end

    def post_params
      params.require(:post).permit(:title, :content, :group_id, files: [])
    end

    def update_post_params
      params.require(:post).permit(:title, :content, files: [], files_to_remove: {})
    end
  end
end
