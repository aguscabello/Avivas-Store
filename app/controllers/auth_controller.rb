class AuthController < ApplicationController
  def login
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:user][:password])
      sign_in user
      redirect_to products_path, notice: "Sesión iniciada correctamente"
    else
      flash.now[:alert] = "Credenciales incorrectas"
      render :login, status: :unprocessable_entity
    end
  end
end
