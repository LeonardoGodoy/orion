module Api
  class InstitutionsController < ::ApiController
    before_action :set_institution, only: [:show, :update]

    def index
      @institutions = InstitutionSearch.new(search_params).results
      render json: @institutions, status: :ok
    end

    def show
      render json: @institution, status: :ok
    end

    def create
      @institution = Institution.new(institution_params)

      if @institution.save
        render json: @institution, status: :created
      else
        render json: @institution.errors, status: :unprocessable_entity
      end
    end

    def update
      if @institution.update(institution_params)
        render json: @institution, status: :ok
      else
        render json: @institution.errors, status: :unprocessable_entity
      end
    end

    private

    def set_institution
      @institution = Institution.find(params[:id])
    end

    def search_params
      params.permit(:name)
    end

    def institution_params
      params.require(:institution).permit(:name)
    end
  end
end