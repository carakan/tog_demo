set :rails_env, "production"

set :deploy_to, "/home/tog/apps/tog"

set :app_domain, "demo.toghq.com"

role :app, "demo.toghq.com"
role :web, "demo.toghq.com"
role :db,  "demo.toghq.com", :primary => true

