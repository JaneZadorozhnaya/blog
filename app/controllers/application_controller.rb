class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!



  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
	redirect_to @article, :alert => exception.message
  end

end
