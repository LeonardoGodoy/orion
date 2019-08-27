module Api
  class GroupsController < ApplicationController
    before_action :set_course, only: [:show, :update]

    def index
      @groups = GroupSearch.new(search_params).results
      render json: @groups
    end

    def show
    end

    def create
      @group = Group.new(group_params)

      respond_to do |format|
        if @group.save
          format.json { render :show, status: :created, location: @group }
        else
          format.json { render json: @group.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @group.update(group_params)
          format.json { render :show, status: :ok, location: @group }
        else
          format.json { render json: @group.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_group
      @group = Group.find(params[:id])
    end

    def search_params
      params.permit(:name, :institution_id, :course_id, :discipline_id)
    end

    def group_params
      params.require(:group).permit(:name)
    end
  end
end