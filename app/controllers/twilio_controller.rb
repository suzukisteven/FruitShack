class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def send_sms
    client = Twilio::REST::Client.new(ENV["TWILIO_SID"], ENV["TWILIO_AUTH_TOKEN"])
    from = '+13462630696',
    to = '+60165532644'

    client.messages.create(
      from: from,
      to: to,
      body: "Hey friend!"
      )
  end
end
