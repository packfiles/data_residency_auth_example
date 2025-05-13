class AddCurrentIdentityToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :current_identity_id, :integer
  end
end
