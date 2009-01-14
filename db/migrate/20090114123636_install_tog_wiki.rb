class InstallTogWiki < ActiveRecord::Migration

  def self.up
    migrate_plugin "tog-wiki", 2
  end

  def self.down
    migrate_plugin "tog-wiki", 0
  end

end
