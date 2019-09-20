module Api
  class GroupsController < ::ApiController
    before_action :set_group, only: [:show, :update]

    def index
      @groups = GroupSearch.new(search_params).results
      render json: @groups, status: :ok
    end

    def show
      render json: @group, status: :ok
    end

    def create
      @group = Group.new(group_params)

      if @group.save
        render json: @group, status: :created
      else
        render json: @group.errors, status: :unprocessable_entity
      end
    end

    def update
      if @group.update(group_params)
        render json: @group, status: :ok
      else
        render json: @group.errors, status: :unprocessable_entity
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