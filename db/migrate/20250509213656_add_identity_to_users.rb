class AddIdentityToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :identities_count, :integer
  end
end
