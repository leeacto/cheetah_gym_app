class AddPersonalToDaywods < ActiveRecord::Migration
  def change
    add_column :daywods, :personal, :boolean
  end
end
