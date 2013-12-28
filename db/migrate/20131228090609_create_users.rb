class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitter_id
      t.string :screen_name
      t.string :name
      t.integer :followers_count
      t.timestamps
    end
    add_index :users, :twitter_id ,unique: true
    add_index :users, :screen_name ,unique: true
  end
end
