class Auth::SessionsController < Devise::SessionsController
  skip_after_filter :verify_authorized
  skip_after_filter :verify_policy_scoped

  def resource_params
    #params.require(:user).permit(:email, :password)
  end

  private :resource_params

end
