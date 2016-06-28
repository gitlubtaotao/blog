class AddRestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_digest, :stringreset_send_at
  end
end
