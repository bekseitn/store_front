class CreateOrderItems < ActiveRecord::Migration[4.2]
  def change
    create_table :order_items do |t|
      t.references :product, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true
      t.references :ordering, index: true, foreign_key: true
      t.integer :unit_price
      t.integer :quantity
      t.integer :total_price
    end
  end
end
