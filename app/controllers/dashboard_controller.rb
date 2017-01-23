class DashboardController < ApplicationController
  def index
    if user_signed_in? 
      redirect_to :controller => 'payments', :action => 'index'
    end 
  end
end
