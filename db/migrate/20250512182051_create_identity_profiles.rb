class CreateIdentityProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :identity_profiles do |t|
      t.string :name
      t.string :avatar_url
      t.string :username
      t.string :uri
      t.references :identity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
