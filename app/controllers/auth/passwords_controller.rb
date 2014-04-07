class Auth::PasswordsController < Devise::PasswordsController
  skip_after_filter :verify_authorized
  skip_after_filter :verify_policy_scoped

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  private :resource_params
end
