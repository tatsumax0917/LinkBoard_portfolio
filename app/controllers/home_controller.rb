class HomeController < ApplicationController
  def top
    if user_signed_in?
      redirect_to user_profile_path(current_user.unique_user_id)
    else
      render :top
    end
  end
end
