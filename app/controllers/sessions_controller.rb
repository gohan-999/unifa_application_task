class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(login_id: params[:user][:login_id])
    if @user&.authenticate(params[:user][:password])
      login(@user)
      redirect_to photos_index_path and return
    end

    @user ||= User.new(user_params)
    @user.password = params[:user][:password] if @user.password.blank?
    @user.valid?
    @user.errors.add(:not_exist_user, '入力したユーザーIDとパスワードが一致するユーザーがいませんでした。') if @user.errors.blank?

    render 'new'
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
