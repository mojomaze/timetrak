set :application, "timetrak"
default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git@github.com:mojomaze/timetrak.git"  # Your clone URL
set :scm, "git"
set :scm_command, "/usr/local/git/bin/git"
set :local_scm_command, "git"
set :user, "mwinkler"  # The server's user for deploys
#set :scm_passphrase, "pray4mojo"  # The deploy user's password

set :branch, "master"

set :deploy_via, :remote_cache

set :deploy_to, "/opt/local/apache2/www/#{application}"

# set :default_environment, { 
#   'PATH' => "/Users/mwinkler/.rvm/bin:/Users/mwinkler/.rvm/gems/ruby-1.9.2-p0@rails3/bin:/Users/mwinkler/.rvm/gems/ruby-1.9.2-p0@global/bin:/Users/mwinkler/.rvm/rubies/ruby-1.9.2-p0/bin:$PATH}",
#   'RUBY_VERSION' => 'ruby 1.9.2-p0',
#   'GEM_HOME' => '/Users/mwinkler/.rvm/gems/ruby-1.9.2-p0',
#   'GEM_PATH' => '/Users/mwinkler/.rvm/gems/ruby-1.9.2-p0' 
# }

# alternative syntax for single server
server "localhost", :app, :web, :db, :primary => true

#role :web, "localhost"                          # Your HTTP server, Apache/etc
#role :app, "localhost"                          # This may be the same as your `Web` server
#role :db,  "localhost", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :use_sudo, false

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start, :roles => :app do 
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end