class SessionsController < ApplicationController  
  def new  
  end  
  
  def create  
    @user = User.authenticate(params[:name], params[:password])
    if @user
      session[:user_id] = @user.id  
      redirect_to '/workouts', :notice => "Logged in!"  
    else  
      flash.now.alert = "Invalid email or password"  
      redirect_to log_in_path
    end  
  end  
  
  def destroy  
    session[:user_id] = nil  
    redirect_to log_in_path, :notice => "Logged out!"  
  end  
end 