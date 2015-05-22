require "bundler/setup"
require "bundler/capistrano"
require 'capistrano-cowboy'

set :deploy_via, :remote_cache
set :keep_releases, 5

set :use_sudo, false
default_run_options[:pty] = true
#ssh_options[:forward_agent] = true
set :default_shell, '/bin/bash'

server "cats.local", :app, :web, :db, primary: true

set :user, "app"
set :deploy_to, "/home/app/app"
set :branch, "master"
set :rails_env, "production"

set :repository,  "git@github.com:theplant/security_app.git"


namespace :deploy do
  task :restart  do
    stop
    start
  end

  task :stop do
    run "test -f #{shared_path}/pids/server.pid && kill -INT `cat #{shared_path}/pids/server.pid`"
  end

  task :start do
    run "cd #{current_path} && ./script/rails s -e #{rails_env} -d"
  end
end

task :precompile_assets do
  run "cd #{release_path} && RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
end

before "deploy:symlink", "precompile_assets"

desc "Double-check that local revision is same as remote"
task "check_revisions" do
  remote = real_revision
  local = `git log #{branch} --format="format:%H" -n 1`.strip

  exit unless remote == local or
    Capistrano::CLI.ui.agree "local #{branch} is at #{local}...\nbut remote #{branch} is at #{remote}.\nAre you sure you want to deploy #{remote}? "
end

before "deploy:update_code", "check_revisions"
after "deploy:restart", "deploy:cleanup"
