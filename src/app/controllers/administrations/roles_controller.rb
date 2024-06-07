class Administrations::RolesController < Administrations::ApplicationController
  before_action :set_role, only: %i[ show create edit update destroy ]

  def index
    @roles = Role.all
  end
  def show
  end
  def new
    @role = Role.new
  end
  def create
    @role = Role.new(role_params)
    @role.aid = generate_aid(Role, 'aid')
    if @role.save
      flash[:success] = "roleを作成しました"
      redirect_to administrations_root_path
    else
      flash.now[:danger] = "作成できませんでした"
      render 'new'
    end
  end
  def edit
  end
  def update
    if @role.update(role_params)
      flash[:success] = '変更しました'
      redirect_to administrations_root_path
    else
      flash.now[:danger] = "更新できませんでした"
      render 'edit'
    end
  end
  def destroy
    # 本当に消す？
  end

  private

  def set_role
    @role = Role.find_by(aid: params[:aid])
  end
  def role_params
    params.require(:role).permit(
      :aid,
      :name,
      :name_id
    )
  end
end