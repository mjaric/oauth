class CreateLineItemsTable < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :cart_id
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 2
      t.integer :quantity, :null => false, :default => 1

      t.timestamps
    end
  end
end
