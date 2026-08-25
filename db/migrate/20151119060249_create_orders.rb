class CreateOrders < ActiveRecord::Migration[4.2]
  def change
    create_table :orders do |t|
      t.integer :total
      t.timestamps null: false
    end
  end
end
