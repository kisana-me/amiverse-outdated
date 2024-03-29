class ApplicationController < ActionController::Base
  include Tools
  include ImageTreatment
  include ApplicationHelper
  include AccountsHelper
  include SessionsHelper
  include ItemsHelper
  include ImagesHelper
  before_action :set_current_account

  private
  def set_current_account
    @current_account = current_account
  end
  def admin_account
    unless logged_in? && @current_account.administrator?
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
    end
  end
  def logged_in_account
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to login_path
    end
  end
  def logged_out_account
    unless !logged_in?
      flash[:danger] = "ログイン済みです"
      redirect_to root_path
    end
  end
  def correct_account(account)
    unless current_account?(account)
      flash[:danger] = "正しいユーザーでログインしてください"
      redirect_to root_path
    end
  end
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
end
