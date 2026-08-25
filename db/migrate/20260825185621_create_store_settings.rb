class CreateStoreSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :store_settings do |t|
      t.text :store_name, null: false, default: 'Online Store'
      t.text :currency, null: false, default: 'USD'
      t.text :contact_email
      t.text :contact_phone
      t.text :logo_url
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
