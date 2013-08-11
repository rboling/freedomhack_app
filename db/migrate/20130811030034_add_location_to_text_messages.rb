class AddLocationToTextMessages < ActiveRecord::Migration
  def change
    add_column :text_messages, :location, :string
  end
end
