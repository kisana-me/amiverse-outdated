class V1::ApplicationController < ApplicationController
  protect_from_forgery

  private

  def api_admin_account
    unless @current_account&.administrator?
      render status: 403
    end
  end
  def api_logged_in_account
    unless @current_account
      render status: 401
    end
  end
  def api_logged_out_account
    if @current_account
      render status: 400
    end
  end

  # CSRF

  def set_csrf_token_cookie
    cookies['CSRF-TOKEN'] = {
      value: form_authenticity_token,
      domain: :all,
      expires: 1.year.from_now,
      secure: ENV["RAILS_SECURE_COOKIES"].present?,
      httponly: true
    }
  end
  def set_csrf_token_header
    response.set_header('X-CSRF-Token', form_authenticity_token)
  end

  # ACCOUNT

  def login_account_data(account)
    return account.as_json(only: [
      :aid,
      :name,
      :name_id,
      :icon_key,
      :banner_key,
      :followers_counter,
      :following_counter,
      :meta,
      :cache,
      :discoverable,
      :manually_approves_followers,
    ])
  end
  def account_data(account)
    account_data_json = account.as_json(only: [
      :aid,
      :name,
      :name_id,
      :location,
      :followers_counter,
      :following_counter,
      :items_counter,
      :birthday,
      :created_at,
      :meta,
      :cache,
      :bot,
      :kind
    ])
    account_data_json['public_key'] = account.ap_public_key
    account_data_json['icon_url'] = ''
    account_data_json['banner_url'] = ''
    account_data_json['summary'] = account.description
    account_data_json['items'] = items_data(account.items)
    return account_data_json
  end
  def with_account_data(account)
    account_data_json = account.as_json(only: [
      :aid,
      :name,
      :name_id,
      :description,
      :cache,
      :bot,
      :kind
    ])
    account_data_json['icon_url'] = ''
    account_data_json['banner_url'] = ''
    return account_data_json
  end
  def ap_account_data(account)
  end

  # ITEM

  def item_data(item)
    item_data_json = item.as_json(only: [
      :aid,
      :content,
      :sensitive,
      :warning_message,
      :foreign,
      :created_at,
      :updated_at,
    ])
    account_data_json = with_account_data(item.account)
    item_data_json['account'] = account_data_json
    images_array_json = []
    item_data_json['reactions'] = []
    return item_data_json
  end
  def items_data(items)
    return items.map {|item|
      item_data(item)
    }
  end

  # TIMELINE

  def timeline_data(tl)
    timeline_data_json = tl.map do |c|
      if c[:object].is_a?(Item)
        { object: 'item', item: item_data(c[:object]) }
      elsif tl[:object].is_a?(Diffusion)
        { object: 'diffuse', item: item_data(c[:object].diffused), diffuser: with_account_data(c[:object].diffuser) }
      end
    end
    return timeline_data_json.to_json
  end

  # MEDIA

  def image(image)
    return image.as_json(only: [
      :aid,
      :name,
      :description,
      :sensitive,
      :warning_message,
      :meta
    ])
  end
  def audio
  end
  def video
  end
end