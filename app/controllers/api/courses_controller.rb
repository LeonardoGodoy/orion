module Api
  class CoursesController < ::ApiController
    before_action :set_course, only: [:show, :update]

    def index
      @courses = CourseSearch.new(search_params).results
      render_success_array(@courses)
    end

    def show
      render_success(@course)
    end

    def create
      @course = Course.new(course_params)

      if @course.save
        render_created(@course)
      else
        render_errors(@course.errors)
      end
    end

    def update
      if @course.update(course_params)
        render_success(@course)
      else
        render_errors(@course.errors)
      end
    end

    private

    def set_course
      @course = Course.find(params[:id])
    end

    def search_params
      params.permit(:name)
    end

    def course_params
      params.require(:course).permit(:name)
    end
  end
end