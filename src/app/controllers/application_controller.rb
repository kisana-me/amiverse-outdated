class ApplicationController < ActionController::Base
  # concerns
  include Tools
  include SessionManagement
  # helpers
  include ApplicationHelper
  before_action :set_current_account
  before_action :set_current_locale
  # flash success:緑 notice:青 alert:黄 danger:赤
  add_flash_types :success, :danger

  unless Rails.env.development?
    rescue_from Exception,                      with: :render_500
    rescue_from ActiveRecord::RecordNotFound,   with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
  end

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  private

  def render_404
    render 'errors/404', status: :not_found
  end
  def render_500
    render 'errors/500', status: :internal_server_error
  end
  def set_current_account
    @current_account = current_account
  end
  def set_current_locale
    locale = 'ja'
    session[:locale] = params[:locale] if params[:locale] && supported_locale?(params[:locale])
    locale = session[:locale] if session[:locale]
    locale = @current_account&.language if @current_account&.language
    I18n.locale = locale
  end
  def administrator_account
    unless @current_account && @current_account.administrator?
      render_404
    end
  end
  def moderator_account
    unless @current_account && @current_account.moderator?
      render_404
    end
  end
  def logged_in_account
    unless @current_account
      flash[:danger] = "ログインしてください"
      redirect_to login_path
    end
  end
  def logged_out_account
    unless !@current_account
      flash[:danger] = "ログイン済みです"
      redirect_to root_path
    end
  end
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  def redirect_back_or(default: root_path)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  def supported_locale?(locale)
    I18n.available_locales.map(&:to_s).include?(locale.to_s)
  end
end
