module Api
  class GroupsController < ::ApiController
    before_action :set_group, only: [:show, :update]

    def index
      @groups = GroupSearch.new(search_params).results
      render_success_array(@groups, GroupSerializer)
    end

    def show
      render_success(@group, GroupSerializer)
    end

    def create
      form = CreateGroupForm.new(group_params)
      form.user = current_user

      if form.perform
        render_created(form.group, GroupSerializer)
      else
        render_errors(form.errors)
      end
    end

    def update
      form = UpdateGroupForm.new(update_group_params)
      form.user_id  = current_user.id
      form.group_id = params[:id]

      if form.perform
        render_success(form.group, GroupSerializer)
      else
        render_errors(form.errors)
      end
    end

    def recomendations
      service = GroupRecomendation.new(current_user.id)
      service.perform
      render_success(service.serialized_groups)
    end

    private

    def set_group
      @group = Group.find(params[:id])
    end

    def search_params
      params.permit(:name, :institution_id, :course_id, :discipline_id, :user_id)
    end

    def group_params
      params.require(:group).permit(:name, :description, :institution_id, :course_id, :discipline_id)
    end

    def update_group_params
      params.require(:group).permit(:name, :description)
    end
  end
end
