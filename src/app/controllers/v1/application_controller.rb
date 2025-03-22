class V1::ApplicationController < ApplicationController
  skip_forgery_protection

  private

  def api_admin_account
    unless @current_account&.administrator?
      head :forbidden
    end
  end
  def api_logged_in_account
    unless @current_account
      head :unauthorized
    end
  end
  def api_logged_out_account
    if @current_account
      head :bad_request
    end
  end

  # CSRF

  def set_csrf_token_cookie
    cookies['CSRF-TOKEN'] = {
      value: form_authenticity_token,
      domain: :all,
      secure: ENV["RAILS_SECURE_COOKIES"].present?,
      httponly: true
    }
  end

end
