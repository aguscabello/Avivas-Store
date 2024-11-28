class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:deactivate, :create, :update]

  def deactivate
    user = User.find(params[:id])
    if current_user.admin? && user != current_user
      user.deactivate!
      redirect_to users_path, notice: "User deactivated."
    else
      redirect_to users_path, alert: "Error. You don't have permission to deactive this user"
    end
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "You don't have access to this section" unless current_user.admin?
  end
end
