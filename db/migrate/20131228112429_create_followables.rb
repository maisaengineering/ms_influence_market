class CreateFollowables < ActiveRecord::Migration
  def change
    create_table :followables do |t|
      t.integer :user_id
      t.integer :follower_id
      t.timestamps
    end
  end
end
