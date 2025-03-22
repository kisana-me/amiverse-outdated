class V1::AccountsController < V1::ApplicationController
  include AccountManagement
  before_action :set_account, only: %i[ show followers following ]
  def show
  end
  def followers
    render json: {
      name_id: @account.name_id,
      count: @account.followers.count,
      followers: @account.followers.map {|follower| account_data(follower)}
    }
  end
  def following
    render json: {
      name_id: @account.name_id,
      count: @account.following.count,
      following: @account.following.map {|following| account_data(following)}
    }
  end
  def update
    pre_icon_key = @account.icon_key
    pre_banner_key = @account.banner_key
    if @account.update(account_update_params)
      generate_varinat_image(params[:account][:icon_key], pre_icon_key, 'icon')
      generate_varinat_image(params[:account][:banner_key], pre_banner_key, 'banner')
      flash[:success] = "更新成功!"
      redirect_to account_path(@account.name_id)
    else
      flash.now[:danger] = "更新できませんでした。"
      render 'edit'
    end
  end
  private
  def set_account
    @account = find_account(params[:name_id])
  end
  def account_params
    params.require(:account).permit(
      :name,
      :name_id,
      :icon_key,
      :banner_key,
      :bio,
      :location,
      :birthday,
      :password,
      :password_confirmation
    )
  end
end