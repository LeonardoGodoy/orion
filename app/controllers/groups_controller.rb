class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    search = GroupSearch.new(search_params)
    @groups = paginate(search.results.order(:name))
  end

  def show
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to @group, notice: "Grupo #{@group.name} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: "Grupo #{@group.name} atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: "Grupo #{@group.name} excluído com sucesso."
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def search_params
    params.permit(search: [:name])[:search] || {}
  end

  def group_params
    params.require(:group).permit(:institution_id, :course_id, :discipline_id, :name)
  end
end
