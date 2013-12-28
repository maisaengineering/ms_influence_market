class CreateItemPrices < ActiveRecord::Migration
  def change
    create_table :item_prices do |t|
      t.integer :item_id
      t.date :date
      t.float :price
      t.string :rear_window_item_ids
      t.string :front_window_item_ids

      t.timestamps
    end
  end
end
