class StaticController < ApplicationController
  include HighVoltage::StaticPage
  skip_after_filter :verify_authorized
  skip_after_filter :verify_policy_scoped

  layout :layout_for_page

  private

  def layout_for_page
    case params[:id]
    when 'home'
      'home'
    else
      'application'
    end
  end

end
