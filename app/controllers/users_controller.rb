class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :destroy]
  before_action :set_user_as_admin, only: [:update, :destroy]
  before_action :set_user, only: :edit

  # GET /users
  # GET /users.json
  def index
    if admin?
      @users = User.all
    else
      redirect_to root_path
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  # render layout: false
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html {
          reset_session
          redirect_to root_path, notice: 'You have successfully signed up.'
        }
        format.js {
          render js: 'alert( "You have successfully signed up." )';
        }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.js { render :new, status: 422, content_type: "text/html" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_user_path(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # at least one admin is necessary
    if @user.is_admin && User.where(is_admin: true).count == 1
      redirect_back(fallback_location: root_path, alert: 'You cannot delete the only admin.')
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if current_user.id == params[:id].to_i
        @user = User.find(params[:id])
      else
        redirect_to root_path
      end
    end

    def set_user_as_admin
      begin
        if admin?
          @user = User.find(params[:id])
        else
          redirect_to root_path
        end
      rescue ActiveRecord::RecordNotFound => exception
        logger.debug exception
        redirect_back(fallback_location: root_path)
      else
      ensure
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :is_admin)
    end
end
