set :application, "timetrak"
set :local_repository, "file:///Users/mwinkler/Projects/SGI/1000/timetrak"
set :repository, "file:///Users/mwinkler/Projects/SGI/1000/timetrak"
set :branch, "master"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/opt/local/apache2/www/#{application}"

set :default_environment, { 
  'PATH' => "/Users/mwinkler/.rvm/bin:/Users/mwinkler/.rvm/gems/ruby-1.9.2-preview3/bin:/Users/mwinkler/.rvm/gems/ruby-1.9.2-preview3@global/bin:/Users/mwinkler/.rvm/rubies/ruby-1.9.2-preview3/bin:$PATH}",
  'RUBY_VERSION' => 'ruby 1.9.2-preview3',
  'GEM_HOME' => '/Users/mwinkler/.rvm/gems/ruby-1.9.2-preview3',
  'GEM_PATH' => '/Users/mwinkler/.rvm/gems/ruby-1.9.2-preview3' 
}

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