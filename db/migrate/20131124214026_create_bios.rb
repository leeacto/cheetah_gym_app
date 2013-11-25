class CreateBios < ActiveRecord::Migration
  def change
    create_table :bios do |t|
      t.integer :user_id
      t.integer :height
      t.integer :weight
      t.text :experience
      t.text :fav
      t.text :unfav

      t.timestamps
    end
  end
end
