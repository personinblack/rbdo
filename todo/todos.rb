# Copyright (c) 2018 personinblack <berkay@tuta.io>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'yaml'
require 'pathname'
require 'fileutils'

#
# todos.rb - todos
#
class Todos
  def initialize
    @todo_list = []
  end

  def <<(todo)
    @todo_list << todo
    printf 'ADDED: '
    todo.display
  end

  def rm!(index)
    @todo_list.fetch(index) do |i|
      puts 'nothing to delete'
      return
    end
    printf 'DELETED: '
    @todo_list.delete_at(index).display
  end

  def display
    if @todo_list.empty?
      puts 'nothing to show'
      return
    end
    i = 0
    @todo_list.each do |todo|
      printf("#{i}. ")
      todo.display
      i += 1
    end
  end

  def load!(file_name)
    return false unless FileTest.exist?(file_name)

    loaded_data = YAML.load_file(file_name)
    @todo_list = loaded_data if loaded_data.instance_of?(Array)
  end

  def save!(file_name)
    unless FileTest.exist?(file_name)
      FileUtils.mkdir_p(Pathname.new(file_name).parent)
      File.new(file_name, 'w+')
    end

    File.open(file_name, 'w+') do |file|
      file.write(@todo_list.to_yaml)
    end
  end

  def size
    @todo_list.size
  end
end
