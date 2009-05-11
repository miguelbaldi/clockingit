class StartDateFixname < ActiveRecord::Migration
  def self.up
    rename_column :tasks, :started_at, :start_date
  end

  def self.down
    rename_column :tasks, :start_date, :started_at
  end
end
