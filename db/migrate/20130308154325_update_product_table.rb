class UpdateProductTable < ActiveRecord::Migration
    def change
        add_column :products, :default_picture_id, :integer
        add_column :products, :in_stock, :boolean, null: false, default: true
        add_column :products, :on_action, :boolean, null: false, default: false
        add_column :products, :discount, :decimal
    end
end
