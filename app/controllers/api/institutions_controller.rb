module Api
  class InstitutionsController < ApplicationController
    before_action :set_institution, only: [:show, :update]

    def index
      @institutions = InstitutionSearch.new(search_params).results
      render json: @institutions
    end

    def show
    end

    def create
      @institution = Institution.new(institution_params)

      respond_to do |format|
        if @institution.save
          format.html { redirect_to @institution, notice: 'Institution was successfully created.' }
          format.json { render :show, status: :created, location: @institution }
        else
          format.html { render :new }
          format.json { render json: @institution.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @institution.update(institution_params)
          format.html { redirect_to @institution, notice: 'Institution was successfully updated.' }
          format.json { render :show, status: :ok, location: @institution }
        else
          format.html { render :edit }
          format.json { render json: @institution.errors, status: :unprocessable_entity }
        end
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