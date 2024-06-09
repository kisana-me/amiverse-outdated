class SettingsController < ApplicationController
  before_action :logged_in_account, except: %i[ index display ]
  def index
    
  end
  def profile
    @images = Image.where(account_id: @current_account.id)
  end
  
  def storage
    @images = Image.where(account_id: @current_account.id, deleted: false)
    @audios = Audio.where(account_id: @current_account.id, deleted: false)
    @videos = Video.where(account_id: @current_account.id, deleted: false)
    @image = Image.new
    @audio = Audio.new
    @video = Video.new
  end
  def security_and_authority
    @current_accounts = current_accounts()
    @current_clients = current_clients()
  end
end
