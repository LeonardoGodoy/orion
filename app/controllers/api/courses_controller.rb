module Api
  class CoursesController < ::ApiController
    before_action :set_course, only: [:show, :update]

    def index
      @courses = CourseSearch.new(search_params).results
      render json: @courses
    end

    def show
      render json: @course, status: :ok
    end

    def create
      @course = Course.new(course_params)

      if @course.save
        render json: @course, status: :created
      else
        render json: @course.errors, status: :unprocessable_entity
      end
    end

    def update
      if @course.update(course_params)
        render json: @course, status: :ok
      else
        render json: @course.errors, status: :unprocessable_entity
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