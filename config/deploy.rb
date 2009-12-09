require 'capistrano/ext/multistage'

#############################################################
#	Stages
##############################################################

set :stages, %w(staging production)
set :default_stage, "staging"

#############################################################
# Settings
#############################################################

set :application, "tog"
set :keep_releases, 5

set :use_sudo, false
set :scm_verbose, true
ssh_options[:username] = "tog"
set :user, "tog"

set :scm, :git
set :branch, "master"
set :repository, "git@github.com:molpe/tog_demo.git"
set :deploy_via, :remote_cache


#############################################################
# => Passenger
#############################################################

namespace :deploy do
  
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
end

