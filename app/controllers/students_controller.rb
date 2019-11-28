class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    search = StudentSearch.new(search_params)
    @students = paginate(search.results.order(:name))
  end

  def show
  end

  def new
    @student = Student.new
  end

  def edit
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to @student, notice: "Estudante #{@student.name} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @student.update(student_params)
      redirect_to @student, notice: "Estudante #{@student.name} atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to students_url, notice: "Estudante #{@student.name} excluído com sucesso."
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def search_params
    params.permit(search: [:name])[:search] || {}
  end

  def student_params
    params.require(:student).permit(:name, :email, :password)
  end
end
