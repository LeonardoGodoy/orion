module Api
  class PerformancesController < ::ApiController
    before_action :set_performance, only: [:show, :update, :destroy]

    def index
      @performances = PerformanceSearch.new(search_params).results
      render_success_array(@performances, PerformanceSerializer)
    end

    def show
      render_success(@performance, PerformanceSerializer)
    end

    def create
      @performance = Performance.new(performance_params)
      @performance.user = current_user

      if @performance.save
        render_created(@performance, PerformanceSerializer)
      else
        render_errors(@performance.errors)
      end
    end

    def update
      if @performance.update(performance_params)
        render_success(@performance, PerformanceSerializer)
      else
        render_errors(@performance.errors)
      end
    end

    def destroy
      if @performance.destroy
        render_success(@performance, PerformanceSerializer)
      else
        render_errors(@performance.errors)
      end
    end

    private

    def set_performance
      @performance = Performance.find_by(id: params[:id], user: current_user)
    end

    def search_params
      params.permit(:user_id, :discipline_id, :year)
    end

    def performance_params
      params.require(:performance).permit(:discipline_id, :year, :description, :value, :max_value)
    end
  end
end
