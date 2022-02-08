class SessionsController < ApplicationController
  
  def new
  end

  def create
    field_params = params[:user]
    user = User.find_by_email(field_params[:email])
    if user && user.authenticate(field_params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
