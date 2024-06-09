class SessionsController < ApplicationController
  before_action :logged_in_account, only: %i[ change_account logout all_logout]

  def create
    account = Account.find_by(name_id: params[:session][:name_id].downcase, deleted: false)
    if account && account.authenticate(params[:session][:password])
      log_in account
      redirect_to root_url, success: t('.success')
    else
      flash.now[:danger] = t('.danger')
      render 'new'
    end
  end
  def logout
    if log_out
      redirect_to root_path, success: t('.success')
    else
      redirect_to settings_others_path, danger: t('.danger')
    end
  end
  def all_logout
    if all_log_out
      redirect_to root_path, success: t('.success')
    else
      redirect_to settings_security_and_authority_path, danger: t('.danger')
    end
  end

  def change
    account = Account.find_by(aid: params[:aid])
    result = change_account(account)
    if result[:status]
      flash[:success] = result[:message]
      redirect_to root_url
    else
      flash[:danger] = result[:message]
      redirect_to settings_security_and_authority_path
    end
  end
  def destroy
    client = Client.find_by(uuid: params[:uuid])
    log_out(client: client)
    flash[:success] = 'OK'
    redirect_to settings_security_and_authority_path
  end

  # 一時的セッション
  def update_current
    if params[:setting]
      session[:setting] ||= {}
      if params[:setting][:dark_mode]
        session[:setting][:dark_mode] = params[:setting][:dark_mode] == '1'
      end
      if params[:setting][:locale]
        session[:setting][:locale] = params[:setting][:locale] == '1'
      end
    end
    redirect_to settings_display_path, success: '変更しました'
  end
end
