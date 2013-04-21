class AddRxToResults < ActiveRecord::Migration
  def change
    add_column :results, :rx, :boolean
  end
end
