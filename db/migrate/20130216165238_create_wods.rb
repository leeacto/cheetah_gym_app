class CreateWods < ActiveRecord::Migration
  def change
    create_table :wods do |t|
      t.string :name
      t.text :desc
      t.string :seq
      t.string :wod_type
      t.integer :baserep

      t.timestamps
    end
  end
end
