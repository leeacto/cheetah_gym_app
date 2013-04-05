class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.float :recd
      t.integer :user_id
      t.integer :daywod_id

      t.timestamps
    end
    add_index :results, :user_id
    add_index :results, :daywod_id
  end
end
