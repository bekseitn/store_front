class CreateProducts < ActiveRecord::Migration[4.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.boolean :active
      t.references :category, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
