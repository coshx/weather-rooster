require "rvm/capistrano"                  # Load RVM's capistrano plugin.
require 'bundler/capistrano'
require 'hipchat/capistrano'

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

load 'deploy/assets'

set :application, "weather-rooster"
set :repository,  "git@github.com:coshx/weather-rooster.git"

set :scm, :git

role :web, "weatherrooster.com"
role :app, "weatherrooster.com"
role :db,  "weatherrooster.com", :primary => true

set :rvm_type, :system
set :rvm_ruby_string, 'ruby-1.9.3@weather-rooster'

set :rvm_bin_path, "/usr/local/rvm/bin"
set :deploy_to, "/opt/#{application}"

set :hipchat_token, "89d684618c0efae42e66b30900961c"
set :hipchat_room_name, "Weather Rooster"
set :hipchat_announce, true

set :branch, "master"

# deploy task for Passenger
namespace :deploy do

  desc "Tell Passenger to restart the app"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :set_current_release, :roles => :app do
    set :current_release, latest_release
  end

  desc "Symlink shared config on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/sensitive.yml #{release_path}/config/sensitive.yml"
  end

end

before 'deploy:finalize_update', 'deploy:set_current_release'
before 'deploy:assets:precompile', 'deploy:symlink_shared'
after "bundle:install", "deploy:migrate"
