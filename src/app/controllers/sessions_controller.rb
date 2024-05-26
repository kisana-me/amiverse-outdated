class SessionsController < ApplicationController
  before_action :logged_in_account, only: %i[ change_account logout all_logout]

  # LOGGING

  def create
    account = Account.find_by(name_id: params[:session][:name_id].downcase, deleted: false)
    if account && account.authenticate(params[:session][:password])
      log_in account
      flash[:success] = t('.success')
      redirect_to root_url
    else
      flash.now[:danger] = '間違っています'
      render 'new'
    end
  end
  def logout
    if @current_account
      account = @current_account
      log_out
    end
    flash[:success] = "#{account.name}からログアウトしました"
    redirect_to root_url
  end
  def all_logout
    all_log_out if @current_account
    flash[:success] = "すべてからログアウトしました"
    redirect_to root_url
  end

  # MANAGEMENT

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
end
