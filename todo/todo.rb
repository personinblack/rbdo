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
