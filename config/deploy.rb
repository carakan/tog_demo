set :default_stage, "staging"

require 'capistrano/ext/multistage'
require 'mongrel_cluster/recipes'

ssh_options[:username] = "tog"
ssh_options[:forward_agent] = true

set :user, "tog"
set :application, "tog"
set :use_sudo, false

set :scm, :git
set :branch, "master"
set :repository, "git://github.com/molpe/tog_demo.git"
set :deploy_via, :remote_cache

set :deploy_to, "/home/tog/apps/demo"

namespace :deploy do
  task :after_deploy do
    run "cd #{deploy_to}/current; rake RAILS_ENV=#{stage} db:migrate"
  end
end