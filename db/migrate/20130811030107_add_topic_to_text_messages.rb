class AddTopicToTextMessages < ActiveRecord::Migration
  def change
    add_column :text_messages, :topic, :string
  end
end
