class AddNoteToResults < ActiveRecord::Migration
  def change
    add_column :results, :note, :text
  end
end
