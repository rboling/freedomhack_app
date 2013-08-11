class TextMessagesController < ApplicationController
  # GET /text_messages
  # GET /text_messages.json
  def index
    @text_messages = TextMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @text_messages }
    end
    begin
      from_number = params["From"]
      message_body = params["Body"]
      the_sender = TextMessage.the_twilio_phone_number
      secret_code = TextMessage.generate_random_string
      new_message_body = message_body + " " + secret_code
      user_id = (User.where(:phone_number => ("+1" + from_number)).first).id
      new_message = TextMessage.create({ :content => new_message_body,
      :receiver => from_number,
      :sender => the_sender,
      :secret_code => secret_code,
      :user_id => user_id
    })
      new_message.send_text_message
    rescue
      puts "\n\n\n\ndidn't get there\n\n\n\n"
    end
  end

  # GET /text_messages/1
  # GET /text_messages/1.json
  def show
    @text_message = TextMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @text_message }
    end
  end

  # GET /text_messages/new
  # GET /text_messages/new.json
  def new
    @text_message = TextMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @text_message }
    end
  end

  # GET /text_messages/1/edit
  def edit
    @text_message = TextMessage.find(params[:id])
  end

  # POST /text_messages
  # POST /text_messages.json
  def create
    @text_message = TextMessage.new(params[:text_message])
    @text_message.secret_code = TextMessage.generate_random_string
    puts "#{@text_message.secret_code}"
    respond_to do |format|
      if @text_message.save
        format.html { redirect_to @text_message, notice: 'Text message was successfully created.' }
        format.json { render json: @text_message, status: :created, location: @text_message }
      else
        format.html { render action: "new" }
        format.json { render json: @text_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /text_messages/1
  # PUT /text_messages/1.json
  def update
    @text_message = TextMessage.find(params[:id])

    respond_to do |format|
      if @text_message.update_attributes(params[:text_message])
        format.html { redirect_to @text_message, notice: 'Text message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @text_message.errors, status: :unprocessable_entity }
      end
    end
  end

  def 

  # DELETE /text_messages/1
  # DELETE /text_messages/1.json
  def destroy
    @text_message = TextMessage.find(params[:id])
    @text_message.destroy

    respond_to do |format|
      format.html { redirect_to text_messages_url }
      format.json { head :no_content }
    end
  end
end
