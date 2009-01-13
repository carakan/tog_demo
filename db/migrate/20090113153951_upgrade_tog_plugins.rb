class UpgradeTogPlugins < ActiveRecord::Migration
  def self.up
    migrate_plugin "tog_core", 6
    migrate_plugin "tog_social", 5
  end

  def self.down
    migrate_plugin "tog_core", 5
    migrate_plugin "tog_social", 1
  end
end
