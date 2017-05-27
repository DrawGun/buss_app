class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout 'site', if: :devise_controller?

  def access_denied(exception)
    redirect_to access_denied_url, :notice => exception.message
  end

end
