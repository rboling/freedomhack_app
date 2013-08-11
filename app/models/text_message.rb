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
  def self.secret_code_find(the_user, the_code)
  	code_found = false
  	refined_user_array = User.all.select{|x| x.id != the_user.id}
  	User.all.each do |user|
  	  text_messages = user.text_messages
  	  text_messages.each do |message|
  	  	if message.secret_code == the_code
  	  	  code_found = true
  	  	  user_to_return = user
  	  	end
  	  end
  	  if code_found
  	  	return user_to_return
  	  else
  	  	return nil
  	  end
  	end
  end

  def self.reconstruct_secret_code(text_message, index)
  	new_string = ''
  	j = index
  	while text_message[j] != " "
  	  new_string += text_message[j]
  	  j += 1
  	end
  	return new_string
  end

  def self.does_another_message_exist(text_message_content)
  	foo = TextMessage.all.select{|x| /#{x.secret_code}/.match(text_message_content) != nil}
  	if foo.length == 0
  	  return false
  	else
  	  the_index = (/#{secret_code}/ =~ (foo[0]))
  	  return self.reconstruct_secret_code(foo[0], the_index)
  	end
  end

  def return_closest_user(location)
  	raise NotImplementedError
  end
end
