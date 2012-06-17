namespace :db do
  desc "Setup application database"
  task :appsetup => [:environment, 'db:drop', 'db:setup', 'db:populate']
end