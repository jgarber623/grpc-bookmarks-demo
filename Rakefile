# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

require 'reek/rake/task'
require 'rubocop/rake_task'

Reek::Rake::Task.new do |task|
  task.fail_on_error = false
  task.source_files = FileList['**/*.rb'].exclude('db/migrate/**/*.rb', 'vendor/**/*.rb')
end

RuboCop::RakeTask.new do |task|
  task.fail_on_error = false
end
