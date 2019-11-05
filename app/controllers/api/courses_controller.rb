module Api
  class CoursesController < ::ApiController
    before_action :set_course, only: [:show, :update]

    def index
      @courses = CourseSearch.new(search_params).results
      render_success_array(@courses, CourseSerializer, metadata: true)
    end

    def show
      render_success(@course, CourseSerializer, metadata: true)
    end

    def create
      @course = Course.new(course_params)

      if @course.save
        render_created(@course, CourseSerializer)
      else
        render_errors(@course.errors)
      end
    end

    def update
      if @course.update(course_params)
        render_success(@course, CourseSerializer)
      else
        render_errors(@course.errors)
      end
    end

    private

    def set_course
      @course = Course.find(params[:id])
    end

    def search_params
      params.permit(:name, :institution_id)
    end

    def course_params
      params.require(:course).permit(:name, :institution_id)
    end
  end
end
