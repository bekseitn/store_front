class AddPictureToProduct < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :picture, :string
  end
end
