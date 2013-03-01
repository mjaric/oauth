class CreateOrdersTable < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.integer :user_id
      t.string :first_name, null: true, length: 50
      t.string :last_name, null: true, length: 50
      t.string :email, null: true, length: 250
      t.string :phone_number, null: true, length: 20
      t.string :phone_number2, null: true, length: 20

      t.string :delivery_address, null: true, length: 300
      t.string :delivery_city, null: true, length: 250
      t.string :delivery_zip_code, null: true, length: 5
      t.string :delivery_country, null: true, length: 150

      t.string :status, null: false, default: 'ordering'

      t.string :comment, null: true
      t.integer :position

      t.timestamps
    end
  end

  def down
    drop_table :orders
  end
end
