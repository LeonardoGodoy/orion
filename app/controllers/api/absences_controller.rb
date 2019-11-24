module Api
  class AbsencesController < ::ApiController
    before_action :set_absence, only: [:show, :update, :destroy]

    def index
      @absences = AbsenceSearch.new(search_params).results
      render_success_array(@absences, AbsenceSerializer)
    end

    def show
      render_success(@absence, AbsenceSerializer)
    end

    def create
      @absence = Absence.new(absence_params)
      @absence.user = current_user

      if @absence.save
        render_created(@absence, AbsenceSerializer)
      else
        render_errors(@absence.errors)
      end
    end

    def update
      if @absence.update(absence_params)
        render_success(@absence, AbsenceSerializer)
      else
        render_errors(@absence.errors)
      end
    end

    def destroy
      if @absence.destroy
        render_success(@absence, AbsenceSerializer)
      else
        render_errors(@absence.errors)
      end
    end

    private

    def set_absence
      @absence = Absence.find_by(id: params[:id], user: current_user)
    end

    def search_params
      params.permit(:user_id, :discipline_id)
    end

    def absence_params
      params.require(:absence).permit(:discipline_id, :date, :year, :quantity)
    end
  end
end
