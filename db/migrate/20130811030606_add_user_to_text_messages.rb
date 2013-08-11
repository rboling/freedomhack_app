class AddUserToTextMessages < ActiveRecord::Migration
  def change
    add_column :text_messages, :user_id, :integer
    add_index :text_messages, :user_id
  end
end
