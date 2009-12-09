set :rails_env, "staging"

set :deploy_to, "/home/hucaweb/apps/tog"

set :app_domain, "demo.toghq.com"

role :app, "demo.toghq.com"
role :web, "demo.toghq.com"
role :db,  "demo.toghq.com", :primary => true

after :deploy, 'deploy:migrate', 'db:seed'

namespace :db do
  desc "Seed db" 
  task :seed, :roles => :app do
    run "cd #{current_path} && rake db:seed RAILS_ENV=#{rails_env}"
  end
end
