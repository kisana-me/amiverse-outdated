class ResourcesController < ApplicationController
  before_action :logged_in_account, only: []

  def index
  end
  def about
  end
  def info
  end
  def help
  end
  def sitemap
  end
  def contact
  end

  def blog
  end
  def release_notes
  end

  def tos
  end
  def privacy_policy
  end
end