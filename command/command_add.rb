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

require_relative 'command'
require_relative '../todo/todo'
require_relative '../argument/argument_date'
require_relative '../argument/argument_time'
require_relative '../argument/argument_text'

#
# command_add.rb - command for adding todo entries to the todo list
#
class CommandAdd
  def initialize(todos)
    @todos = todos
    @command = Command.new('add')
  end

  def handle(argv)
    arguments = @command.handle(argv)

    return unless arguments.instance_of?(Hash)

    @todos << Todo.new(
      ArgumentText.new(arguments['text']).parsed,
      ArgumentTime.new(arguments['time']).parsed(
        ArgumentDate.new(arguments['date'])
      )
    )
  end
end
