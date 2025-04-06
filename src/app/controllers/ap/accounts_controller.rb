class Ap::AccountsController < Ap::ApplicationController
  include AccountManagement
  before_action :set_account, only: %i[ show ]

  def show
  end

  private

  def set_account
    @account = find_account(params[:name_id])
  end
end