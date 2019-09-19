module Api
  class DisciplinesController < ::ApiController
    before_action :set_discipline, only: [:show, :update]

    def index
      @disciplines = DisciplineSearch.new(search_params).results
      render json: @disciplines, status: :ok
    end

    def show
      render json: @discipline, status: :ok
    end

    def create
      @discipline = Discipline.new(discipline_params)

      if @discipline.save
        render json: @discipline, status: :created
      else
        render json: @discipline.errors, status: :unprocessable_entity
      end
    end

    def update
      if @discipline.update(discipline_params)
        render json: @discipline, status: :ok
      else
        render json: @discipline.errors, status: :unprocessable_entity
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