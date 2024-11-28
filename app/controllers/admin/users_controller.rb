class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [ :index, :show, :edit, :update, :destroy ]
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  def index
    @users = User.all
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

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
      params.require(:user).permit(:username, :email, :phone, :role, :joining_date, :active, :password, :password_confirmation)
  end


  def authorize_admin!
    redirect_to root_path, alert: "You are not authorized to perform this action." unless current_user.admin?
  end
end
