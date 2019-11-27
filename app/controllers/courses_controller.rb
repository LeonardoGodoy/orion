class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    search = CourseSearch.new(search_params)
    @courses = paginate(search.results.order(:name))
  end

  def show
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course, notice: "Curso #{@course.name} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: "Curso #{@course.name} atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_url, notice: "Curso #{@course.name} excluído com sucesso."
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def search_params
    params.permit(search: [:name, :institution_id])[:search] || {}
  end

  def course_params
    params.require(:course).permit(:name)
  end
end
