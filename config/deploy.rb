require "rvm/capistrano"

set :application, "steam-buddy"
set :repository,  "https://YusefOuda:006b29gqB35@github.com/YusefOuda/steam-buddy.git"

set :deploy_to, "/home/rails/steam-buddy"

set :scm, :git
set :branch, "master"

set :user, "yusef"

set :use_sudo, false

set :rails_env, "production"

set :deploy_via, :copy

set :keep_releases, 3

default_run_options[:pty] = true

server "steam-buddy.com", :app, :web, :db, :primary => true

role :resque_worker, "steam-buddy.com"
role :resque_scheduler, "steam-buddy.com"

set :workers, { "games" => 2, "filter" => 2 }

set :resque_extra_env, "RAILS_ENV=production"

set :resque_environment_task, true

after "deploy:restart", "resque:restart"

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end