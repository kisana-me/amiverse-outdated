class AccountsController < ApplicationController
  include ActivityPub
  before_action :set_account, except: %i[ show ]
  before_action :logged_in_account, except: %i[ show ]

  def show
    return unless @account = find_account_by_nid(params[:name_id])
    items = @account.items.order(id: :desc).where(
      visibility: :public_share,
      status: :shared,
      deleted: false
    ).includes(
      :images,
      :videos,
      :reactions,
      :emojis,
      :replying,
      :repliers,
      :quoting,
      :quoters
    )
    @page = current_page(page_param: params[:page])
    @pages = total_page(objects: items)
    @items = paged_objects(page: @page, objects: items)
  end
  def reject_follow
    account = find_account_by_nid(params[:name_id])
    this_follow_params = {
      followed: @current_account,
      follower: account
    }
    if account.foreigner
      if follow = Follow.find_by(this_follow_params)
        ap_reject_follow(followed: @current_account, follower: account,
        follow_id: File.join(@current_account.activitypub_id, "@#{@current_account.name_id}/follow/#{follow.uuid}")
      )
        follow.delete
        flash[:success] = 'フォロワー取り消し依頼しました'
      else
        flash[:danger] = 'フォローされていません'
      end
    else
      Follow.where(this_follow_params).delete_all
      flash[:success] = 'フォロワーを削除しました'
    end
    redirect_to root_path
  end
  def follow
    if @current_account.name_id == params[:name_id]
      redirect_to root_path
      flash[:danger] = 'フォローできません'
      return
    end
    account = find_account_by_nid(params[:name_id])
    this_follow_params = {
      followed: account,
      follower: @current_account
    }
    if account.foreigner
      if Follow.exists?(this_follow_params)
        follow = Follow.find_by(this_follow_params)
        ap_undo_follow(followed: account, follower: @current_account, id: follow.uid)
        follow.delete
        flash[:success] = 'フォロー取り消し依頼しました'
      else
        this_follow_params.merge!({uid: SecureRandom.uuid})
        Rails.logger.info(this_follow_params[:uid])
        follow = Follow.new(this_follow_params)
        if follow.save!
          ap_follow(followed: account, follower: @current_account, id: this_follow_params[:uid])
          flash[:success] = 'フォロー依頼しました'
        else
          flash[:danger] = 'フォロー依頼できません'
        end
      end
    else
      if Follow.exists?(this_follow_params)
        Follow.where(this_follow_params).delete_all
        flash[:success] = 'フォローを取り消しました'
      else
        this_follow_params.merge!({accepted: true})
        follow = Follow.new(this_follow_params)
        if follow.save!
          flash[:success] = 'フォローしました'
        else
          flash[:danger] = '失敗しました'
        end
      end
    end
    redirect_to root_path
  end
  def update
    @account = @current_account

    if params[:account][:settings_dark_mode]
      @account.settings ||= {}
      @account.settings['default'] ||= {}
      @account.settings['default']['dark_mode'] = params[:account][:settings_dark_mode] == '1'
    end
    if @account.update(account_update_params)
      flash[:success] = "更新しました"
      redirect_to account_path(@account.name_id)
    else
      flash[:danger] = "更新できませんでした#{@account.errors.full_messages.join(", ")}"
      redirect_to settings_account_path
    end
  end
  def password_update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "更新しました"
      redirect_to user_path(@user.user_id)
    else
      flash[:danger] = "更新できませんでした"
      redirect_to settings_account_path
    end
  end
  def destroy
  end
  private
  def set_account
    @account = Account.find_by(name_id: params[:name_id])
    unless @account
      render_404
    end
  end
  def account_params
    params.require(:account).permit(
      :name,
      :name_id,
      :icon_data,
      :banner_data,
      :description,
      :location,
      :birthday,
      :password,
      :password_confirmation
    )
  end
  def account_update_params
    params.require(:account).permit(
      :name,
      :name_id,
      :icon_data,
      :banner_data,
      :description,
      :location,
      :birthday
    )
  end
  def account_password_update_params
    params.require(:account).permit(
      :password,
      :password_confirmation
    )
  end
end