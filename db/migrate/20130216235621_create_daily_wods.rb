class CreateDailyWods < ActiveRecord::Migration
  def change
    create_table :daily_wods do |t|
      t.date :performed
      t.integer :wod_id

      t.timestamps
    end
    add_index :daily_wods, :wod_id
  end
end
