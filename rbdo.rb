#!/usr/bin/env ruby

# Copyright (c) 2018 personinblack <berkay@tuta.io>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software
# and associated documentation files (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
# BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'date'
require 'yaml'
require 'pathname'
require 'fileutils'

class Todo
  def initialize(text, date)
    unless text.instance_of?(String) && date.instance_of?(DateTime)
      raise 'Invalid todo!'
    end
    @text = text
    @date = date
  end

  def print(todos)
    todos << {'text' => @text, 'date' => @date}
  end

  def load(todo_as_hash)
    return Todo.new(todo_as_hash['text'], todo_as_hash['date'])
  end

  def display
    remaining_days = (@date - DateTime.now).to_f
    printf "#{@text} in #{remaining_days.to_i} days" \
    " (#{@date.strftime('%d/%m/%Y %H:%M:%S')})"

    if remaining_days < 0
      printf ' <I hope you didn\'t miss it...>'
    end
    puts
  end
end

class Todos
  def initialize
    @todo_list = Array.new
  end

  def <<(todo)
    @todo_list << todo
    printf 'ADDED: '
    todo.display
  end

  def rm(index)
    printf 'DELETED: '
    @todo_list.delete_at(index).display
  end

  def display
    i = 0;
    @todo_list.each do |todo|
      printf("#{i.to_s}. ")
      todo.display
      puts unless i == @todo_list.size - 1
      i += 1
    end
  end

  def load(file_name)
    loaded_data = YAML.load_file(file_name)
    @todo_list = loaded_data unless !loaded_data.instance_of?(Array)
  end

  def save(file_name)
    unless @todo_list.empty?
        unless FileTest.exist?(file_name)
        FileUtils.mkdir_p(Pathname.new(file_name).parent)
        File.new(file_name, 'w+')
        end

        File.open(file_name, 'w+') do |file|
        file.write(@todo_list.to_yaml)
        end
    end
  end
end

todos = Todos.new
todos.load("#{ENV['XDG_CONFIG_HOME']}/rbdo/data.yml")

todos << Todo.new('Todo #1', DateTime.new(2077, 1, 1))
todos << Todo.new('Todo #2', DateTime.new(2077, 1, 2))
puts

todos.display
puts

todos.rm(1)
todos.rm(0)
puts

todos.save("#{ENV['XDG_CONFIG_HOME']}/rbdo/data.yml")
