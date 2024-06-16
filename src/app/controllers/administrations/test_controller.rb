class Administrations::TestController < Administrations::ApplicationController
  include AccountManagement
  include Tools
  include Dummy

  def index
  end
  def new_accounts
    # contents = hashtag
    # 100.times do |i|
    #   item = Item.new(
    #     account: @current_account,
    #     content: contents[i],
    #     aid: generate_aid(Item, 'aid')
    #   )
    #   item.save
    # end
  end
  def create_accounts
    account_times = params[:account_times].to_i || 0
    account_offset = params[:account_offset].to_i || 0
    item_times = params[:item_times].to_i || 0
    item_offset = params[:item_offset].to_i || 0
    account_times.times do |i|
      i += account_offset
      account = Account.new(
        name: "test#{i}",
        name_id: "test#{i}",
        password: "testtest#{i}",
        password_confirmation: "testtest#{i}",
        status: :activated,
        aid: generate_aid(Account, 'aid')
      )
      if account.save
        Rails.logger.info "Account #{i} created successfully."
        item_times.times do |i|
          i += item_offset
          item = Item.new(
            account: account,
            content: "test-item-#{i}",
            aid: generate_aid(Item, 'aid')
          )
          if item.save
            Rails.logger.info "Item #{i} created successfully."
          else
            Rails.logger.info "Failed to create item #{i}: #{item.errors.full_messages.join(", ")}"
          end
        end
      else
        Rails.logger.info "Failed to create account #{i}: #{account.errors.full_messages.join(", ")}"
      end
    end
    flash[:success] = 'end'
    redirect_to administrations_new_accounts_path
  end
  def explore
  end
  def show
    @account = find_account(params[:id])
  end
  def new
  end
  def generate
    @key_pair = generate_rsa_key_pair
    flash.now[:success] = '生成成功'
    render 'new'
  end
  def verify
    begin
      message = params[:message]
      en_sign = generate_signature(@current_account.private_key, message)
      result = verify_signature(@current_account.public_key, params[:signature], message)
    rescue => e
      Rails.logger.info('====Error====')
      Rails.logger.info(e.message)
    end
    Rails.logger.info('====en_sign====')
    Rails.logger.info(en_sign)
    Rails.logger.info('====result====')
    Rails.logger.info(result)
    Rails.logger.info('====end====')
    if result
      flash.now[:success] = '成功'
    else
      flash.now[:danger] = '失敗'
    end
    render 'new'
  end
  def digest
    hexdigest = Digest::SHA256.hexdigest(params[:digest])
    base64digest = Digest::SHA256.base64digest(params[:digest])
    @digest = params[:digest]
    flash.now[:success] = "hexdigest: #{hexdigest},\nbase64digest: #{base64digest}"
    render 'new'
  end
  def generate_ap_key_pair
    account = @current_account
    key_pair = generate_rsa_key_pair()
    if account.ap_private_key.blank? && account.ap_public_key.blank?
      account.ap_private_key = key_pair[:private_key]
      account.ap_public_key = key_pair[:public_key]
      account.activitypub = true
      account.ap_uri = File.join(ENV['APP_URL'], "accounts/#{account.aid}")
      account.save!
      flash[:success] = '作成しました'
    else
      flash[:danger] = 'すでに存在'
    end
    redirect_to administrations_test_path
  end
end