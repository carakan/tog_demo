set :app_domain, "tog.larnaby.net"
set :mongrel_conf, "#{deploy_to}/current/config/mongrel/staging.yml"

role :app, "tog.larnaby.net"
role :web, "tog.larnaby.net"
role :db,  "tog.larnaby.net", :primary => true
