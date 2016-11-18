class SessionsController < ApplicationController
  def create
    email = params[:user][:email]
    password = params[:user][:password]
    user = User.find_by_email(email)

    respond_to do |format|
      if user && user.authenticate( password )
        reset_session # Countermeasure of Session Fixation attack; this also destroys csrf-token
        session[:user_id] = user.id
        format.json {
          # generate new csrf token and send it to the client as well as user info
          render "login_info", locals: {
            user: user,
            csrf_param: request_forgery_protection_token,
            csrf_token:  form_authenticity_token 
          }
        } 
      else
        format.html {
          flash.now[:alert] = "Invalid email/password"
          render partial: "login_form", status: 422 
        }
        format.json {
          render json: '{"error": "Invalid email/password"}', status: 422
        }
      end
    end
  end
  
  def destroy
    reset_session
    respond_to do |format|
      format.html {
        redirect_to root_path
      }
      format.json {
        render json: Hash[ request_forgery_protection_token, form_authenticity_token ].to_json
      }
    end
  end
end
