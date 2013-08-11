class TextMessage < ActiveRecord::Base
  attr_accessible :content, :receiver, :sender, :secret_code, :user_id
  attr_accessor :content, :receiver, :sender, :secret_code
  belongs_to :user
  def twilio_sid
  	"AC50070372767bdf26a090b08007bba07f"
  end

  def twilio_token
  	"8ae1cdbb08d55b99cab34174c3cd8bbb"
  end

  def self.the_twilio_phone_number
  	"2245209581"  	
  end

  def twilio_phone_number
  	"2245209581"
  end

  def self.verify_incoming_phone_number(phone_number)
    phone_number.slice!(0)
    phone_number.slice!(0)
    return phone_number
  end

  def self.generate_random_string
  	beginning_of_string = 0...6
  	the_string = beginning_of_string.map{(65 + rand(26)).chr}
  	return the_string.join
  end

  def send_text_message
  	@twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)
  	@twilio_client.account.sms.messages.create(
  	  :from => "+1#{twilio_phone_number}",
  	  :to => receiver,
  	  :body => (content)  	
  	  )
  end
  def self.get_location(context)
  	begin
      return context.split("@")[-1]
    rescue
      return nil
    end
  end
end
