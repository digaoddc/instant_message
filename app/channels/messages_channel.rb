class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'messages_channel'
  end

  def speak(data)
    ActionCable.server.broadcast "messages_channel", render_message(data)
  end

  def appear(data)
    speak(data)
  end

  private

  def render_message(data)
    {
      message: translate(data),
      from: data['from'],
      time: time_now,
      action: data['action'],
      dialect: data['dialect']
    }
  end

  def translate(data)
    DialectTranslator.perform(data['message'], data['dialect'])
  end

  def time_now
    Time.now.strftime("%D %R")
  end
end
