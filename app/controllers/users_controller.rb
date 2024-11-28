class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @user.deactivate! 
    redirect_to users_path, notice: "User was successfully deactivated."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :phone, :role, :joining_date)
  end

  def authorize_admin!
    redirect_to root_path, alert: "You are not authorized to perform this action." unless current_user.admin?
  end
end
