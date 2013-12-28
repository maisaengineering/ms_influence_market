class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer :item_id
      t.string :tarde_type
      t.date :date
      t.string :order_type
      t.float :price

      t.timestamps
    end
  end
end
