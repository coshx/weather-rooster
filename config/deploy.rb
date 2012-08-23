require "rvm/capistrano"                  # Load RVM's capistrano plugin.
require 'bundler/capistrano'

load 'deploy/assets'

set :application, "weather-rooster"
set :repository,  "git@github.com:coshx/weather-rooster.git"

set :scm, :git

role :web, "173.255.224.143"
role :app, "173.255.224.143"
role :db,  "173.255.224.143", :primary => true

set :rvm_type, :system
set :rvm_ruby_string, 'ruby-1.9.3@weather-rooster'

set :rvm_bin_path, "/usr/local/rvm/bin"
set :deploy_to, "/opt/#{application}"

# deploy task for Passenger
namespace :deploy do

  desc "Tell Passenger to restart the app"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :set_current_release, :roles => :app do
    set :current_release, latest_release
  end
end

before 'deploy:finalize_update', 'deploy:set_current_release'
