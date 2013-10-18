class RenameDescToDescription < ActiveRecord::Migration
  def up
    rename_column(:wods, :desc, :description)
  end

  def down
    rename_column(:wods, :description, :desc)
  end
end
