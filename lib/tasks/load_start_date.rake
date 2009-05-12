#TODO Finish this task!
def find_active_tasks
  tasks = Task.find()
end
def generate_started_at_date(task)
  logger.info "\n\n>>|generate_started_at_date[task_id=#{task.id}, due_date=#{task.due_date}, duration=#{task.duration}]|<<\n\n"
  due_dth = task.due_date
  unless task.users.empty? || due_dth.nil?
    workday_duration = task.users.first.workday_duration 
    workdays = task.duration / workday_duration
    
    due_dth = due_dth.to_datetime + 1
    logger.info "\n\n>>|workdays #{workdays} dias|<<\n\n"
    workdays.downto(1) do |i|
      logger.info "\n\n>>|passei aqui #{i}|<<\n\n"
      due_dth = due_dth - 1
      # 0 = Domingo
      # 1 = Segunda
      # 2 = Terça
      # 3 = Quarta
      # 4 = Quinta
      # 5 = Sexta
      # 6 = Sábado
      due_dth = due_dth - 1 if due_dth.wday == 6
      due_dth = due_dth - 2 if due_dth.wday == 0

    end
    logger.info "\n\n>>|Start date #{due_dth.strftime('%A %d/%m/%Y')} week day #{due_dth.wday} class #{due_dth.class}|<<\n\n"
    task.start_date = due_dth
  end
end
namespace :start_dates do
  desc "Load start date field for every capable task on database."
  task :load => :environment do
    # Your task will be executed here, just plug it all in.
    puts "call sub rotine"
  end
end