class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :phone, presence: true
    validates :role, inclusion: { in: %w[admin manager employee], message: "%{value} it's not a valid role" }
    validates :joining_date, presence: true


    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }



      def deactivate!
        token = Devise.friendly_token # Genera un token para el usuario desactivado.
        update!(previous_password: encrypted_password, password: token, password_confirmation: token, active: false)
      end

      def reactivate!
        update!(password: previous_password,
                password_confirmation: previous_password,
                previous_password: nil,
                active: true)
      end

    def admin?
      role == "admin"
    end

    def manager?
      role == "manager"
    end

    def employee?
      role == "employee"
    end
end
