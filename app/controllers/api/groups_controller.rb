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
      @group = Group.new(group_params)

      if @group.save
        render_created(@group, GroupSerializer)
      else
        render_errors(@group.errors)
      end
    end

    def update
      if @group.update(group_params)
        render_success(@group, GroupSerializer)
      else
        render_errors(@group.errors)
      end
    end

    private

    def set_group
      @group = Group.find(params[:id])
    end

    def search_params
      params.permit(:name, :institution_id, :course_id, :discipline_id, :user_id)
    end

    def group_params
      params.require(:group).permit(:name, :institution_id, :course_id, :discipline_id)
    end
  end
end