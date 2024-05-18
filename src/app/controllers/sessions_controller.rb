class SessionsController < ApplicationController
  before_action :logged_in_account, only: %i[ index destroy ]
  def index
    @sessions = Session.where(account_id: @current_account.id, deleted: false)
  end
  def new
  end
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
  def change_account
    account = Account.find_by(aid: params[:aid])
    result = change_account_session(account)
    if result[:status]
      flash[:success] = result[:message]
      redirect_to root_url
    else
      flash[:danger] = result[:message]
      redirect_to root_url
    end
  end
  def edit
  end
  def update
  end
  def logout
    if logged_in?
      name = @current_account
      log_out(@current_account)
    end
    flash[:success] = "#{name}からログアウトしました"
    redirect_to root_url
  end
  def all_logout
    all_log_out if logged_in?
    flash[:success] = "すべてからログアウトしました"
    redirect_to root_url
  end
  def delete
    session = Session.find(params[:id])
    if session.update(deleted: true)
      flash[:success] = "更新成功!"
      redirect_to root_url
    else
      flash.now[:danger] = "更新できませんでした。"
      render 'settings/security_and_authority'
    end
  end
end
