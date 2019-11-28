class InstitutionsController < ApplicationController
  before_action :set_institution, only: [:show, :edit, :update, :destroy]

  def index
    search = InstitutionSearch.new(search_params)
    @institutions = paginate(search.results.order(:name))
  end

  def show
  end

  def new
    @institution = Institution.new
  end

  def edit
  end

  def create
    @institution = Institution.new(institution_params)

    if @institution.save
      redirect_to @institution, notice: "Instituição #{@institution.name} criada com sucesso."
    else
      render :new
    end
  end

  def update
    if @institution.update(institution_params)
      redirect_to @institution, notice: "Instituição #{@institution.name} atualizada com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @institution.destroy
    redirect_to institutions_url, notice: "Instituição #{@institution.name} excluída com sucesso."
  end

  private

  def set_institution
    @institution = Institution.find(params[:id])
  end

  def search_params
    params.permit(search: [:name])[:search] || {}
  end

  def institution_params
    params.require(:institution).permit(:name)
  end
end
