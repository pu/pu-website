class Admin::DashboardsController < ApplicationController
  
  before_filter :require_user
  
  layout 'admin'
  
  def show
    render
  end

end