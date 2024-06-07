class SignupController < ApplicationController
  include InvitationManagement

  def index
  end
  def check # 招待コードの入力
    if Rails.application.config.x.initial
      @account = Account.new
      render 'entry'
    end
  end
  def entry # アカウント情報の入力
    if Rails.application.config.x.initial # 初回
      @account = Account.new
    elsif Rails.application.config.x.server_property.open_registrations # 登録可
    else # その他
      if check_code(code: params[:code])
        session[:code] = params[:code]
        @account = Account.new
      else
        flash.now[:danger] = '招待コードが正しくありません'
        render 'check'
      end
    end
  end
  def create
    @account = Account.new(account_params)
    if Rails.application.config.x.initial # 初回
      create_initial
      return
    elsif Rails.application.config.x.server_property.open_registrations # 登録可
    else # その他
      invitation = check_code(code: session[:code])
      if invitation
      else
        render 'entry'
        return
      end
    end
    @account.aid = generate_aid(Account, 'aid')
    if @account.save
      if Rails.application.config.x.initial # 初回
      elsif Rails.application.config.x.server_property.open_registrations # 登録可
      else # その他
        if invitation
          invitation.accounts << @account
          invitation.update(uses: invitation.uses + 1)
          session[:code].clear
        end
      end
      flash[:success] = "アカウントが作成されました"
      redirect_to login_path
    else
      flash.now[:danger] = "間違っています"
      render 'entry'
    end
  end

  private

  def account_params
    params.require(:account).permit(
      :name,
      :name_id,
      :description,
      :location,
      :birth,
      :password,
      :password_confirmation
    )
  end
  def create_initial
    @account.aid = generate_aid(Account, 'aid')
    @account.roles << Role.create(name: '管理者', name_id: 'administrator', aid: generate_aid(Role, 'aid'))
    if @account.save
      flash[:success] = "管理者アカウントが作成されました"
      redirect_to login_path
    else
      flash.now[:danger] = "管理者アカウントを作成できませんでした"
      render 'entry'
    end
    Rails.application.config.x.initial = false
  end
end
