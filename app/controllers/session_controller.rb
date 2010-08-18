class SessionController < ApplicationController
  def new
    if !!session[:user_id]
      redirect_to root_path
    end
  end
  
  def create
    hash = params || {}
    @user = User.find_by_email(hash[:login]) || User.find_by_name(hash[:login])
    p @user
    if @user && @user.authenticate(hash[:password])
      session[:user_id] = @user.id
      flash[:notice] = t('controller.logged_in')
      redirect_to root_path
    else    
      flash[:error] = t('controller.login_fail')
      redirect_to root_path
    end
  end
  
  def destroy
    reset_session
    flash[:notice] = t('controller.logged_out')
    redirect_to root_path
  end
end
