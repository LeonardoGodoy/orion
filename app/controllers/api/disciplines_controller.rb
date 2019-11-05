module Api
  class DisciplinesController < ::ApiController
    before_action :set_discipline, only: [:show, :update]

    def index
      @disciplines = DisciplineSearch.new(search_params).results
      render_success_array(@disciplines, DisciplineSerializer, metadata: true)
    end

    def show
      render_success(@discipline, DisciplineSerializer, metadata: true)
    end

    def create
      @discipline = Discipline.new(discipline_params)

      if @discipline.save
        render_created(@discipline, DisciplineSerializer)
      else
        render_errors(@discipline.errors)
      end
    end

    def update
      if @discipline.update(discipline_params)
        render_success(@discipline, DisciplineSerializer)
      else
        render_errors(@discipline.errors)
      end
    end

    private

    def set_discipline
      @discipline = Discipline.find(params[:id])
    end

    def search_params
      params.permit(:name, :course_id)
    end

    def discipline_params
      params.require(:discipline).permit(:name, :course_id)
    end
  end
end
