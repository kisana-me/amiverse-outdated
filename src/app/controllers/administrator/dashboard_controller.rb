class Administrator::DashboardController < Administrator::ApplicationController
  before_action :logged_in_account
  def index
  end
  private
end
