class Auth::RegistrationsController < Devise::RegistrationsController
  skip_after_filter :verify_authorized
  skip_after_filter :verify_policy_scoped

  def resource_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  private :resource_params

end
