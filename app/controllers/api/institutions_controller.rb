module Api
  class InstitutionsController < ::ApiController
    before_action :set_institution, only: [:show, :update]

    def index
      @institutions = InstitutionSearch.new(search_params).results
      render_success_array(@institutions, InstitutionSerializer, metadata: true)
    end

    def show
      render_success(@institution, InstitutionSerializer, metadata: true)
    end

    def create
      @institution = Institution.new(institution_params)

      if @institution.save
        render_created(@institution, InstitutionSerializer)
      else
        render_errors(@institution.errors)
      end
    end

    def update
      if @institution.update(institution_params)
        render_success(@institution, InstitutionSerializer)
      else
        render_errors(@institution.errors)
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
