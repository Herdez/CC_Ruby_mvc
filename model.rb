#'csv' is required
require 'csv'

#'Task' class is defined
class Task
  attr_accessor :name, :completed

  def initialize(name, completed=false)
  	@name = name
  	@completed = completed
  end
end

#'Record' class with methods for model
class Record
  
  #'csv' is saved 
	def save(task)
  	CSV.open('list.csv', "a+") do |csv|
         csv << [task.name, task.completed]
		end
  end

  #all tasks are saved
  def all_save(task)
  	CSV.open('list.csv', "wb") do |csv|
  		task.each do |task|
  		  csv << [task.name, task.completed]
  		end
		end
  end

  #it creates a new object task
  def create(name)
  	Task.new(name)
  end

  #it deletes the task selected
  def delete(num)
  	list_new = []
  	list = read
  	list.each_with_index do |task, index|
      if index+1 != num.to_i
        list_new << task
      end
  	end
  	list_new
  end

  #it updates the task selected
  def update(num)
  	list = read
  	list.each_with_index do |task, index|
  		task.completed = true if index+1 == num.to_i 
  	end
  	list
  end

  #it returns the name task selected
  def get_index(num)
  	task_name = " "
  	list = read
  	list.each_with_index do |task, index|
  		task_name = task.name if index+1 == num.to_i 
  	end
  	task_name
  end

  #it creates an Array with objects from csv
  def read
  	task_list = []
		CSV.foreach('list.csv') do |row|
       task_list << Task.new(row[0], row[1])
    end
    task_list
  end
end

