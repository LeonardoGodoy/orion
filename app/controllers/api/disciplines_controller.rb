module Api
  class DisciplinesController < ::ApiController
    before_action :set_discipline, only: [:show, :update]

    def index
      @disciplines = DisciplineSearch.new(search_params).results
      render_success_array(@disciplines)
    end

    def show
      render_success(@discipline)
    end

    def create
      @discipline = Discipline.new(discipline_params)

      if @discipline.save
        render_created(@discipline)
      else
        render_errors(@discipline.errors)
      end
    end

    def update
      if @discipline.update(discipline_params)
        render_success(@discipline)
      else
        render_errors(@discipline.errors)
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