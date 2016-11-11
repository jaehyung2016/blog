class SessionsController < ApplicationController
  def create
    email = params[:user][:email]
    password = params[:user][:password]
    logger.debug [email, password]
    user = User.find_by_email(email)
    logger.debug user.inspect

    respond_to do |format|
      if user && user.authenticate( password )
        format.json { render json: '' } #TODO define json object with necessary info
      else
        format.html {
          flash.now[:alert] = "Invalid email/password"
          render partial: "layouts/login_form", status: 422 
        }
        format.json { render json: '{"error": "Invalid email/password"}', status: 422 }
      end
    end
  end
  
  def destroy
  end
end
