class V1::AccountsController < V1::ApplicationController
  before_action :set_account, only: %i[ show followers following ]
  def show
    render json: account_data(@account)
  end
  def show_old
    render json: {
      name_id: @account.name_id,
      name: @account.name,
      icon_url: generate_ati_url(@account.account_id, 'icon', @account.icon_key),
      banner_url: generate_ati_url(@account.account_id, 'banner', @account.banner_key),
      bio: @account.bio,
      location: @account.location,
      birthday: @account.birthday,
      followers: @account.followers.count,
      following: @account.following.count,
      items_count: @account.items_count,
      created_at: @account.created_at,
      updated_at: @account.updated_at,
      public_key: @account.public_key,
      items: @account.items.map {|item| {
        item_id: item.item_id,
        item_type: item.item_type,
        meta: item.meta,
        content: item.content,
        sensitive: item.sensitive,
        version: item.version,
        created_at: item.created_at,
        updated_at: item.updated_at,
        reactions: item.reactions.group(:reaction_id).count.map { |key, value| {
          reaction_id: key,
          content: item.reactions.find_by(reaction_id: key).content,
          count: value
        }},
        images: item.images.map {|image| {
          image_id: image.image_id,
          name: image.name,
          description: image.description,
          url: generate_ati_url(image.account.account_id, 'images', image.image_id)
        }}
      }}
    }
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
    @account = find_account_by_nid(params[:name_id])
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