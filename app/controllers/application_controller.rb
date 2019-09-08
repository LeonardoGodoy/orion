class ApplicationController < ActionController::Base
  def paginate(scope)
    scope.page(params[:page]).per(params[:resultset])
  end
end
