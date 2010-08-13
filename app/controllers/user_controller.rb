class UserController < ApplicationController
  before_filter :logged_in
  
  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User information updated!"
    else
      flash[:error] = "User information update failed!"
    end  
      redirect_to edit_user_path
  end
end
