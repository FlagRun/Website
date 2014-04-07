class Auth::UnlocksController < Devise::UnlocksController
  skip_after_filter :verify_authorized
  skip_after_filter :verify_policy_scoped
end
