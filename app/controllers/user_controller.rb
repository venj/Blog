class UserController < ApplicationController
  before_filter :logged_in
  
  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    if @user.update_attributes(params[:user])
      flash[:notice] = t('controller.user_info_succ')
    else
      flash[:error] = t('controller.user_info_fail')
    end  
      redirect_to edit_user_path
  end
end
