class TextMessage < ActiveRecord::Base
  attr_accessible :content, :receiver, :sender
  attr_accessor :content, :receiver, :sender
  def twilio_sid
  	"AC50070372767bdf26a090b08007bba07f"
  end

  def twilio_token
  	"8ae1cdbb08d55b99cab34174c3cd8bbb"
  end

  def twilio_phone_number
  	"2245209581"
  end

  def send_text_message
  	@twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)
  	@twilio_client.account.sms.messages.create(
  	  :from => "+1#{twilio_phone_number}",
  	  :to => receiver,
  	  :body => content
  	)
  end
end