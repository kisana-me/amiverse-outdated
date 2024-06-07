class Administrations::ApplicationController < ApplicationController
  before_action :administrator_account
  private
end