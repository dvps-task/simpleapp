# config valid only for current version of Capistrano
lock "3.8.0"

server "node1", user: "vagrant"

set :application, "simpleapp"
set :repo_url, "git@github.com:dvps-task/simpleapp.git"
set :deploy_to, "/home/#{fetch(:user)}/app/#{fetch(:application)}"
set :log_level, :debug
#set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{tmp/sockets log config/puma public/spree}
set :sockets_path, Pathname.new("#{fetch(:deploy_to)}/shared/tmp/sockets/")

namespace :deploy do
  task :restart do
    invoke 'puma:restart'
  end
end

namespace :simpleapp_sample do
  task :load do
    on roles(:app) do
      within release_path do
        ask(:confirm, "Are you sure you want to delete everything and start again? Type 'yes'")
        if fetch(:confirm) == "yes"
          execute :rake, "db:reset AUTO_ACCEPT=true"
          execute :rake, "spree_sample:load"
        end
      end
    end
  end
end

namespace :puma do
  desc "Restart puma instance for this application"
  task :restart do
    on roles fetch(:puma_roles) do
      within release_path do
        execute :bundle, "exec pumactl -S #{fetch(:puma_state)} restart"
      end
    end
  end

  desc "Show status of puma for this application"
  task :status do
    on roles fetch(:puma_roles) do
      within release_path do
        execute :bundle, "exec pumactl -S #{fetch(:puma_state)} stats"
      end
    end
  end

  desc "Show status of puma for all applications"
  task :overview do
    on roles fetch(:puma_roles) do
      within release_path do
        execute :bundle, "exec puma status"
      end
    end
  end
end
