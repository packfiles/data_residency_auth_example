class CreateIdentities < ActiveRecord::Migration[8.0]
  def change
    create_table :identities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :token
      t.string :refresh_token

      t.timestamps
    end
    add_index :identities, :provider
    add_index :identities, :uid
    add_index :identities, :token
    add_index :identities, :refresh_token
  end
end
