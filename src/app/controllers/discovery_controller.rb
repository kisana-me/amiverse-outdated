class DiscoveryController < ApplicationController
  before_action :logged_in_account
  def index
    @items_test = Item.where(deleted: false, account_id: 1)
    word_counter_service = WordCounterService.new
    @frequent_words = word_counter_service.frequent_words(@items_test)
  end
  private
end
