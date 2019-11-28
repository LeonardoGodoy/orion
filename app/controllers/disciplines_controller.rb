class DisciplinesController < ApplicationController
  before_action :set_discipline, only: [:show, :edit, :update, :destroy]

  def index
    search = DisciplineSearch.new(search_params)
    @disciplines = paginate(search.results.order(:name))
  end

  def show
  end

  def new
    @discipline = Discipline.new
  end

  def edit
  end

  def create
    @discipline = Discipline.new(discipline_params)

    if @discipline.save
      redirect_to @discipline, notice: "Disciplina #{@discipline.name} criada com sucesso."
    else
      render :new
    end
  end

  def update
    if @discipline.update(discipline_params)
      redirect_to @discipline, notice: "Disciplina #{@discipline.name} atualizada com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @discipline.destroy
    redirect_to disciplines_url, notice: "Disciplina #{@discipline.name} excluída com sucesso."
  end

  private

  def set_discipline
    @discipline = Discipline.find(params[:id])
  end

  def search_params
    params.permit(search: [:name, :course_id])[:search] || {}
  end

  def discipline_params
    params.require(:discipline).permit(:name)
  end
end
