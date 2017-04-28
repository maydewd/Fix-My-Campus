class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to current_user.school
    else
      render :layout => 'welcome'
    end
  end
end
