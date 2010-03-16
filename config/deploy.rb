set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

load File.join(File.dirname(__FILE__), 'deploy/config.rb')

namespace :deploy do  
  
  before  "deploy:migrate", "deploy:create_database_yml"
  after   "deploy:update_code", "deploy:migrate"
  before  "symlink", 'web:disable'
  after   "symlink", 'asset:build_package_files'
  after   "restart", 'web:enable'
  after   "deploy", "deploy:cleanup"
  
  namespace :web do
    desc <<-DESC
      Present a maintenance page to visitors. Disables your application's web \
      interface by writing a "maintenance.html" file to each web server. The \
      servers must be configured to detect the presence of this file, and if \
      it is present, always display it instead of performing the request.
    DESC
    task :disable, :roles => :web, :except => { :no_release => true } do
     invoke_command "cp #{current_path}/config/templates/* #{shared_path}/system/"
    end
    
    task :enable, :roles => :web, :except => { :no_release => true } do
      run "rm #{shared_path}/system/maintenance*.html"
    end
  end 
  
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "Create the database yaml file"
  task :create_database_yml do
    db_config = <<-EOF
    #{stage}:    
      adapter: mysql
      encoding: utf8
      username: #{application}
      password: #{database_password}
      database: #{application}_#{stage}
      host: localhost
    migration:    
      adapter: mysql
      encoding: utf8
      username: deployment
      password: #{deployment_database_password}
      database: #{application}_#{stage}
      host: localhost
    EOF
    
    put db_config, "#{release_path}/config/database.yml"
  end
  
  # this is the db:migrate task from capistrano 2.5.8 with a correct rake command
  desc <<-DESC
    Run the migrate rake task. By default, it runs this in most recently \
    deployed version of the app. However, you can specify a different release \
    via the migrate_target variable, which must be one of :latest (for the \
    default behavior), or :current (for the release indicated by the \
    `current' symlink). Strings will work for those values instead of symbols, \
    too. You can also specify additional environment variables to pass to rake \
    via the migrate_env variable. Finally, you can specify the full path to the \
    rake executable by setting the rake variable. The defaults are:

      set :rake,           "rake"
      set :rails_env,      "production"
      set :migrate_env,    ""
      set :migrate_target, :latest
  DESC
  task :migrate, :roles => :db, :only => { :primary => true } do
    rake = fetch(:rake, "rake")
    rails_env = fetch(:rails_env, "production")
    migrate_env = fetch(:migrate_env, "")
    migrate_target = fetch(:migrate_target, :latest)

    directory = case migrate_target.to_sym
      when :current then current_path
      when :latest  then current_release
      else raise ArgumentError, "unknown migration target #{migrate_target.inspect}"
      end
    run "cd #{directory}; #{rake} RAILS_ENV=#{migrate_env} db:migrate"
  end
  
end

namespace :db do  
  
  desc 'Dumps the production database to db/production_data.sql on the remote server'
  task :remote_db_dump, :roles => :db, :only => { :primary => true } do
    run "cd #{deploy_to}/#{current_dir} && " +
      "rake RAILS_ENV=#{rails_env} db:database_dump --trace" 
  end

  desc 'Downloads db/production_data.sql from the remote production environment to your local machine'
  task :remote_db_download, :roles => :db, :only => { :primary => true } do  
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.download!("#{deploy_to}/#{current_dir}/db/production_data.sql", "db/production_data.sql")
      end
    end
  end

  desc 'Cleans up data dump file'
  task :remote_db_cleanup, :roles => :db, :only => { :primary => true } do
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.remove! "#{deploy_to}/#{current_dir}/db/production_data.sql" 
      end
    end
  end 

  desc 'Dumps, downloads and then cleans up the production data dump'
  task :remote_db_runner do
    remote_db_dump
    remote_db_download
    remote_db_cleanup
  end
end

namespace :asset do
  
  namespace :sass do
    before 'asset:build_package_files', 'asset:sass:update'
    desc "build css files from sass"
    task :create, :roles => :web do
      run "cd #{current_path}; rake RAILS_ENV=#{rails_env} rake sass:update"
    end
  end
  
  desc "build asset packager's merged javascript and stylesheet files"
  task :build_package_files, :roles => :web do
    run "cd #{current_path}; rake RAILS_ENV=#{rails_env} asset:packager:build_all"
  end
  
  after "deploy:symlink", "asset:link_picture_path"
  desc "symlink picture path"
  task :link_picture_path, :roles => :web do
    run "umask 02 && mkdir -p #{shared_path}/pictures/kids"
    run "ln -nfs #{shared_path}/pictures/kids #{release_path}/public/pictures/kids"
  end
  
  
  after "deploy:symlink", "asset:link_cache_path"
  desc "symlink cache path"
  task :link_cache_path, :roles => :web do
    invoke_command "ln -nfs #{shared_path}/cache #{release_path}/public/cache"
  end
  
  after "deploy:symlink", "asset:link_assets_path"
  desc "symlink assets path"
  task :link_assets_path, :roles => :web do
    invoke_command "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  end
  
  after "deploy:setup", "asset:create_asset_paths"
  task :create_asset_paths, :roles => :web do
    invoke_command "#{try_sudo} mkdir -p #{shared_path}/assets"
    invoke_command "#{try_sudo} chmod g+w #{shared_path}/assets"
    
    invoke_command "#{try_sudo} mkdir -p #{shared_path}/cache"
    invoke_command "#{try_sudo} chmod g+w #{shared_path}/cache"
  end
  
end

namespace :db do
  namespace :mysql do
    
    desc "create database for application"
    task :create, :roles => :db do
      set :root_password, Capistrano::CLI.password_prompt("MySQL root password: ")
      run "mysql -uroot -p#{root_password} -e \"CREATE DATABASE #{application}_#{stage};\""
    end
    
    before 'db:mysql:create_deployment_user', 'db:mysql:create'
    desc "create deployment user"
    task :create_deployment_user, :roles => :db do
      unless deployment_database_password == ''
        set :root_password, Capistrano::CLI.password_prompt("MySQL root password: ")
        commands =  ["mysql -uroot -p#{root_password} -e \"CREATE USER 'deployment'@'localhost' IDENTIFIED BY '#{deployment_database_password}';\""]
        commands << "mysql -uroot -p#{root_password} -e \"GRANT SELECT, INSERT, UPDATE, DELETE, ALTER, DROP, CREATE, INDEX ON #{application}_#{stage} . * TO 'deployment'@'localhost' WITH GRANT OPTION ;\"";
        
        run commands.join('; ')
      else
        puts "\nENTER PASSWORD FOR MySQL USER deployment\n\n"
      end
    end
    
    desc "create mysql user for application"
    task :create_application_user, :roles => :db do
      unless database_password == ''
        set :root_password, Capistrano::CLI.password_prompt("MySQL root password: ")
        commands = ["mysql -uroot -p#{root_password} -e \"CREATE USER '#{application}'@'localhost' IDENTIFIED BY '#{database_password}';\""]
        commands << "mysql -uroot -p#{root_password} -e \"GRANT SELECT, INSERT, UPDATE, DELETE ON #{application}_#{stage} . * TO '#{application}'@'localhost';\"";
        
        run commands.join('; ')
      else
        puts "\nENTER PASSWORD FOR MySQL USER #{application}\n\n"
      end
    end
    
    desc "create mysql for deployment and application"
    task :create_database_users, :roles => :db do end
    after :create_database_users, :create_deployment_user
    after :create_database_users, :create_application_user
    
    desc "show mysql user"
    task :show_users, :roles => :db do
      set :root_password, Capistrano::CLI.password_prompt("MySQL root password: ")
      run "mysql -uroot -p#{root_password} -e \"select host, user from mysql.user\\G;\""
    end
    
    desc "show grants; specify user with USER"
    task :show_grants, :roles => :db do
      set :root_password, Capistrano::CLI.password_prompt("MySQL root password: ")
      unless ENV['USER']
        user = "CURRENT_USER"
      else
        user = "'#{ENV['USER']}'@localhost"
      end
      run "mysql -uroot -p#{root_password} -e \"show grants for #{user};\""
    end
    
  end
end

namespace :gems do
  desc "install all required gems"
  task :install do
    sudo "cd #{current_dir}; rake RAILS_ENV=#{rails_env} #{migrate_env} db:migrate"
  end
end
