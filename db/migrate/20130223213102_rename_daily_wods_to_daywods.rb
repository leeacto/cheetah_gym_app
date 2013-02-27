class RenameDailyWodsToDaywods < ActiveRecord::Migration
  def change
  	rename_table :daily_wods, :daywods
  end
end
