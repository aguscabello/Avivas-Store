class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [ :index, :show, :edit, :update, :destroy ]
  before_action :set_user, only: [ :show, :edit, :update, :destroy, :edit_profile ]

  def index
    @users = User.all
  end

  def profile
    @user = current_user
  end

  def edit_profile
  end


  def update_profile
    @user = current_user

    if @user.update(user_params)
      redirect_to profile_admin_users_path(@user), notice: "Profile was successfully updated."
    else
      render :profile
    end
  end

  def show
  end

  def new
    @user = User.new
  end



  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def create
    Rails.logger.debug user_params.inspect
      @user = User.new(user_params)

      if @user.save
        redirect_to admin_user_path(@user), notice: "User was successfully created."
      else
        flash.now[:alert] = "Please, complete the form."
        render :new
      end
  end

  def destroy
    @user.deactivate!
    redirect_to admin_users_path, notice: "User was successfully deactivated."
  end


  def reactivate
    @user = User.find_by(id: params[:id])

    if @user.nil?
      redirect_to admin_users_path, alert: "User not found."
      return
    end

    @user.reactivate!
    redirect_to admin_users_path, notice: "User was successfully reactivated."
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
      params.require(:user).permit(:username, :email, :phone, :role, :joining_date, :active, :password, :password_confirmation)
  end


  def authorize_admin!
    redirect_to root_path, alert: "You are not authorized to perform this action." unless current_user.admin? || current_user.manager?
  end
end
