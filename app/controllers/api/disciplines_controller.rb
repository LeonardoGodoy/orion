module Api
  class DisciplinesController < ApplicationController
    before_action :set_discipline, only: [:show, :update]

    def index
      @disciplines = DisciplineSearch.new(search_params).results
      render json: @disciplines
    end

    def show
    end

    def create
      @discipline = Discipline.new(discipline_params)

      respond_to do |format|
        if @discipline.save
          format.json { render :show, status: :created, location: @discipline }
        else
          format.json { render json: @discipline.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @discipline.update(discipline_params)
          format.json { render :show, status: :ok, location: @discipline }
        else
          format.json { render json: @discipline.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_discipline
      @discipline = Discipline.find(params[:id])
    end

    def search_params
      params.permit(:name)
    end

    def discipline_params
      params.require(:discipline).permit(:name)
    end
  end
end