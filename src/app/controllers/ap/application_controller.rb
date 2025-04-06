class Ap::ApplicationController < ApplicationController
  skip_forgery_protection

  private

  def api_ap
    unless @current_account&.administrator?
      head :forbidden
    end
  end
end
