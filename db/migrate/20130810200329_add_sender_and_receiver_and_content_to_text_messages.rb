class AddSenderAndReceiverAndContentToTextMessages < ActiveRecord::Migration
  def change
    add_column :text_messages, :sender, :string
    add_column :text_messages, :receiver, :string
    add_column :text_messages, :content, :text
  end
end
