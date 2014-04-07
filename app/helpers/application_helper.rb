module ApplicationHelper

  def twitterized_type(type)
    case type.to_sym
      when :alert
        'alert-warning'
      when :error
        'alert-danger'
      when :notice
        'alert-info'
      when :success
        'alert-success'
      else
        type.to_s
    end
  end

  def kramdown(text)
    # TODO Parse @username and #tags possibly %groups
    parsed =sanitize Kramdown::Document.new(text, input: 'GFM', coderay_css: :class).to_html.gsub(/<pre>/, "\n<pre>\n")
    # parsed.gsub!(/(?<=<p>)@\w+(?=<\/p>)/, "<a href='#{$1}'>#{$1}</a>")
  end

  # Network Administrators & Administrators can bypass security with only few exceptions
  def can_bypass?
    true if user_signed_in? && current_user.netadmin? || current_user.admin?
  end

end
