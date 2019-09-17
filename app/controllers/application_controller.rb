class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :authenticate_user!

  def paginate(scope)
    scope.page(params[:page]).per(params[:resultset])
  end

  def layout_by_resource
    devise_controller? ? 'devise' : 'application'
  end
end
