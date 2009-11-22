# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  include HoptoadNotifier::Catcher unless RAILS_ENV == 'development'
  
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  helper_method :page_title
  
  before_filter :current_user
  
  
  def page_title(title = nil)
    if title == nil
      @page_title || "#{self.controller_name}: #{self.action_name}"
    else
      @page_title = title + " | Projekthilfe Uganda e.V."
    end
  end
  
  def require_user
    unless current_user
      flash[:notice] = "Bitte loggen Sie sich ein!"
      #redirect_to new_admin_user_session_url
      redirect_to new_user_session_path
      return false
    end
  end
  
  def current_user_session
    @current_user_session ||= user_session
  end
  
end