#This is a 'CRUD' programe for tasks. In other words is 
#a 'to-do list'

#It´s required 'model.rb' and 'view.rb' file.
require_relative 'model.rb'
require_relative 'view.rb'

#It is class that controls 'view' and 'model'
class ListController
  #initialized instance '@model' and '@view'
	def initialize(input)
    @model = Record.new
    @view = View.new
    run(input)
		@list = []
	end

  #This method operate interaction between 'view' and 'model'
  #through methods.
  def run(input)
    task = input
    task_name = "#{task[1..-1].join(" ")}"
    case task[0] 
      when "add" then add_task(task_name)
      when "index" then read_index
      when "delete" then delete_task(task_name)
      when "complete" then update_complete(task_name)
    end
  end

  #Read index from 'all_task'
	def read_index
    all_tasks = @model.read
    @view.show_index(all_tasks)
	end

  #Delete selected task
	def delete_task(num)
    get_index(num, 1)
    keep_tasks = @model.delete(num)
    @model.all_save(keep_tasks)
    read_index
    @view.message_delete
  end

  #Display task name
  def get_index(num, num_task)
    name_task = @model.get_index(num)
    @view.show_name(name_task, num_task)
  end

  #It call to get name from task
  def get_name(task_name)
    @view.get_name(task_name)
  end

  #It updates selected task
  def update_complete(num)
    get_index(num, 2)
    keep_tasks = @model.update(num)
    @model.all_save(keep_tasks)
    read_index
    @view.message_update
  end

  #It adds tasks
  def add_task(task_name)
    get_name(task_name)
    task = @model.create(task_name)
    @model.save(task)
    @view.message_save
  end

end

#It receives values from user
user_input  = ARGV
ListController.new(user_input)
