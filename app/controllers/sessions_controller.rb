class SessionsController < ApplicationController
  
  def new
  end

  def create
    field_params = params[:user]
    if user = User.authenticate_with_credentials(field_params[:email], field_params[:password])
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
