class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  def index
    search = AdminSearch.new(search_params)
    @admins = paginate(search.results)
  end

  def show
  end

  def new
    @admin = Admin.new
  end

  def edit
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to admins_url, notice: "Admin #{@admin.name} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @admin.update(admin_params)
      redirect_to admins_url, notice: "Admin #{@admin.name} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @admin.destroy
    redirect_to admins_url, notice: "Admin #{@admin.name} excluído com sucesso."
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def search_params
    params.permit(search: [:name])[:search] || {}
  end

  def admin_params
    params.require(:admin).permit(:name, :email, :password)
  end
end
