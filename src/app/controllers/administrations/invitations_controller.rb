class Administrations::InvitationsController < Administrations::ApplicationController
  before_action :set_invitation, only: %i[ show edit update ]

  def index
    @invitations = Invitation.all
  end
  def show
  end
  def new
    @invitation = Invitation.new
  end
  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.creator = @current_account
    @invitation.aid = generate_aid(Invitation, 'aid')
    if @invitation.save
      flash[:success] = "招待を作成しました"
      redirect_to administrations_invitations_path
    else
      flash.now[:danger] = "招待を作成できません"
      render 'new'
    end
  end
  def edit
  end
  def update
    if @invitation.update(invitation_params)
      flash[:success] = '更新しました'
      redirect_to administrations_invitations_path
    else
      flash.now[:danger] = "更新できません"
      render 'edit'
    end
  end
  def destroy
    # 本当に消す？
  end

  private

  def set_invitation
    @invitation = Invitation.find_by(aid: params[:aid])
  end
  def invitation_params
    params.require(:invitation).permit(
      :name, :code, :max_uses, :expires_at,
      :account_id, :max_uses, :deleted
    )
  end
end