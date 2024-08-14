class Administrations::AccountsController < Administrations::ApplicationController
  before_action :set_account, except: %i[ index ]

  def index
    @accounts = Account.all
  end
  def new
  end
  def create
  end
  def edit
  end
  def update
    if @account.update(account_params)
      flash[:success] = '変更しました'
      redirect_to administrations_accounts_path
    else
      flash.now[:danger] = "変更できませんでした"
      render 'edit'
    end
  end
  def destroy
    if @account.update(deleted: true)
      flash[:success] = '変更しました'
      redirect_to administrations_accounts_path
    else
      flash.now[:danger] = "変更できませんでした"
      redirect_to admin_accounts_path
    end
  end

  # 関連などの編集
  def extra_edit
    @account = get_account(aid: params[:account_aid])
  end
  def extra_update
    @account = get_account(aid: params[:account_aid])
    # roles
    if params[:account] && params[:account][:role_aids]
      @account.roles.clear
      roles_to_add = Role.where(aid: params[:account][:role_aids])
      @account.roles << roles_to_add
    else
      @account.roles.clear
    end
    # badges
    if params[:account] && params[:account][:badge_aids]
      @account.badges.clear
      badges_to_add = Badge.where(aid: params[:account][:badge_aids])
      @account.badges << badges_to_add
    else
      @account.badges.clear
    end

    if @account.save!
      flash[:success] = '変更しました'
      redirect_to administrations_accounts_path
    else
      flash.now[:danger] = "変更できませんでした"
      render 'edit'
    end
  end

  private

  def get_account(aid: params[:aid])
    Account.find_by(aid: aid)
  end
  def set_account
    @account = get_account
  end
  def account_params
    params.require(:account).permit(
      :name, :name_id, :bio, :location, :birthday,
      :authenticated, :public_visibility, :role, :activated,
      :sensitive, :explorable,
      :locked, :silenced, :suspended, :frozen, :deleted
      )
  end
end