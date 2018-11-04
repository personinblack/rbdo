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

#
# command.rb - cli command
#
class Command
  def initialize(name, arguments)
    @name = name
    @arguments = arguments
  end

  def handle(command)
    name = Command.split_name(command)
    arguments = Command.split_arguments(command)
    return arguments if name == @name
  end

  def self.split_name(command)
    command.split.each do |part|
      return part unless part.start_with?('--')
    end
  end

  def self.split_arguments(command)
    arguments = {}
    command.split.each do |part|
      if part.start_with?('--')
        argument = part[2, part.size]
        arguments[argument.split('=')[0]] = argument.split('=')[1]
      end
    end
    arguments
  end
end
