module Api
  class CoursesController < ApplicationController
    before_action :set_course, only: [:show, :update]

    def index
      @courses = CourseSearch.new(search_params).results
      render json: @courses
    end

    def show
    end

    def create
      @course = Course.new(course_params)

      respond_to do |format|
        if @course.save
          format.json { render :show, status: :created, location: @course }
        else
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @course.update(course_params)
          format.json { render :show, status: :ok, location: @course }
        else
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
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