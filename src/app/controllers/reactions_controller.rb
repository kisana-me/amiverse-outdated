class ReactionsController < ApplicationController
  before_action :logged_in_account
  #before_action :set_item, only: %i[ show edit update destroy ]
  def react
    #Item.first.reactions.create(account: account, emoji: Emoji.first)
    emoji = Emoji.find_by(
      aid: params[:emoji_aid],
      deleted: false
    )
    @item = Item.find_by(
      aid: params[:item_aid],
      deleted: false
    )
    this_react_params = {
      account_id: @current_account.id,
      emoji_id: emoji.id,
      item_id: @item.id
    }
    if Reaction.exists?(this_react_params)
      Reaction.where(this_react_params).delete_all
      #flash[:success] = 'リアクションを取り消しました'
    elsif Reaction.new(this_react_params).save
      #flash[:success] = 'リアクションしました'
    else
      flash[:danger] = '失敗しました'
      render 'items/show', status: :unprocessable_entity
    end
  end

  private

  def reaction_params
    params.require(:reaction).permit(
      :reaction_type,
      :content,
      :description,
      :category
    )
  end
end
