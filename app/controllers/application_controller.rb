class ApplicationController < ActionController::Base
  include SessionsHelper

  def authenticate_user
    if current_user.blank?
      redirect_to sessions_new_path
    end
  end
end
