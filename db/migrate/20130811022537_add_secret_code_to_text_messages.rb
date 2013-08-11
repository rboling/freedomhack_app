class AddSecretCodeToTextMessages < ActiveRecord::Migration
  def change
    add_column :text_messages, :secret_code, :string
  end
end
