#TODO Finish this task!
def execute
  tasks = Task.find(:all, :conditions => ['due_at IS NOT NULL AND duration IS NOT NULL AND duration > 0 AND status IN (0,1)'])
  tasks.each do |task|
    puts "Task: #{task.name} duration=#{task.duration} due_at=#{task.due_at} completed_at=#{task.completed_at} status=#{task.status}"
    task.save
  end
  puts "Number of tasks: #{tasks.size}"
end

namespace :start_dates do
  desc "Load start date field for every capable task on database."
  task :load => :environment do
    execute
  end
end