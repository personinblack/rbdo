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

require_relative 'rbdo/version'
require_relative 'rbdo/todo/todo'
require_relative 'rbdo/todo/todos'
require_relative 'rbdo/command/command'
require_relative 'rbdo/command/command_add'
require_relative 'rbdo/command/command_rm'
require_relative 'rbdo/command/command_ls'
require_relative 'rbdo/command/command_help'

#
# RBDO - main module
#
module RBDO
  class Error < StandardError
  end

  DEF_DATA_LOCATION = "#{ENV['XDG_CONFIG_HOME']}/rbdo/data.yml".freeze

  todos = Todos.new
  todos.load!(DEF_DATA_LOCATION)

  handled = false

  [
    CommandAdd.new(todos), CommandLS.new(todos),
    CommandRM.new(todos), CommandHelp.new
  ].each do |command|
    if command.handle(ARGV)
      handled = true
      puts unless command.is_a?(CommandLS)
    end
  end

  CommandHelp.new.handle(['help']) unless handled
  CommandLS.new(todos).handle(['ls'])

  todos.save!(DEF_DATA_LOCATION)

  # TODO: return the help message if none of the commands handled the ARGV
end
