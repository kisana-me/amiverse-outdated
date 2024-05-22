class Administrator::TestController < Administrator::ApplicationController
  include ActivityPub
  include Tools

  def index
  end
  def explore
  end
  def show
    @account = account(id_to_uri(params[:id]))
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
  private
end