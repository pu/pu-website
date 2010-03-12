#############################################################
#  Application
#############################################################

set :application,       "pu_website"
set :deploy_to,         "/home/deploy/#{application}"

#############################################################
#  Settings
#############################################################

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false
set :scm_verbose, false
set :rails_env,   "production"
set :migrate_env, "migration"

#############################################################
#  Servers
#############################################################

set :user, "deploy"
set :domain, "#{production_host}"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#  Git
#############################################################

set :scm, :git
set :branch, "master"
set :scm_user, 'git'
set :scm_passphrase, ""
set :repository, "git@github.com:pu/pu-website.git"
#set :repository, "git@git.basiszwo.com:#{application}.git"
set :deploy_via, :export
#set :deploy_via, :remote_cache
#set :git_enable_submodules, 1