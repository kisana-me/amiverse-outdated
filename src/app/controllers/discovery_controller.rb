class DiscoveryController < ApplicationController
  before_action :logged_in_account, except: %i[ index ]
  include TrendManagement
  def index
    @trend = current_trend()
  end
  private
end
