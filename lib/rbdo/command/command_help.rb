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

require 'pastel'
require_relative 'command'

module RBDO
  #
  # command_help.rb - command for showing off the usage
  #
  class CommandHelp
    def initialize
      @command = Command.new('help')
    end

    def handle(argv)
      return false unless @command.handle(argv).instance_of?(Hash)

      pastel = Pastel.new
      header = pastel.bright_yellow.bold.underline.detach
      section = pastel.bright_cyan.bold.detach
      command = pastel.black.on_white.detach

      puts <<~HELP
        #{header['commands']}

          #{section['.add']}
          #{command['rbdo add --text="blah" --date=28/01/2019']}

          #{section['.ls']}
          #{command['rbdo ls']}

          #{section['.rm']}
          #{command['rbdo rm --index=5']}

        #{header['arguments']}

          #{section['--text']}
          content of the todo entry. example:
          #{command['rbdo add --text="blah"']}

          #{section['--date']}
          date of the todo entry (year and month are optional). example:
          #{command['rbdo add --date=28/01/2019 --text="blah"']}

          #{section['--time']}
          time of the todo entry (minute and second are optional). example:
          #{command['rbdo add --time=18:03:08 --text="blah"']}

          #{section['--time']}
          index of the todo entry required for the rm command. example:
          #{command['rbdo rm --index=5']}
      HELP
      true
    end
  end
end
