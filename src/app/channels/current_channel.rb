class CurrentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "current_channel"
    Rails.logger.info("=========subscribed=========")
    Rails.logger.info(current_account.aid)
  end

  def unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast('current_channel', data)
  end
end
