class InstallForums < ActiveRecord::Migration
  def self.up
    migrate_plugin "tog_forum", 1
  end

  def self.down
    migrate_plugin "tog_forum", 0
  end
end
