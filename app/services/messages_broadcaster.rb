class MessagesBroadcaster
  CHANNEL = 'messages_channel'.freeze

  def initialize(data, translator = DialectTranslator)
    @data = data
    @translator = translator
  end

  def execute
    ActionCable.server.broadcast CHANNEL, render_message(data)
  end

  private

  attr_reader :data, :translator

  def render_message(data)
    {
      message: translate(data),
      from: data['from'],
      time: time_now,
      dialect: data['dialect']
    }
  end

  def translate(data)
    translator.perform(data['message'], data['dialect'])
  end

  def time_now
    Time.now.strftime("%D %R")
  end
end