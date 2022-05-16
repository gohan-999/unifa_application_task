class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(login_id: params[:user][:login_id])
    if @user&.authenticate(params[:user][:password])
      login(@user)
      redirect_to photos_index_path
    else
      @user ||= User.new(user_params)
      @user.valid?
      flash.alert = @user.errors.full_messages
      redirect_to sessions_new_path
    end
  end

  def destroy
    logout
    redirect_to sessions_new_path
  end

  private

  def user_params
    params.require(:user).permit(:login_id, :password)
  end
end
