#!/usr/bin/env ruby
require 'io/console'

#
# ugly as f*ck but does the trick (w. some exceptions, e.g. backspace)
# loop that refreshes the screen until user cancelles it (ctrl+c) and takes commands in-between
# w. ':' prefix (e.g. ':text "blaah"')
# enables me to interact with already started processes 
#

class InputWaiter
  def initialize()
    @paused = false
    @text = "running it for the %d-th time.."
  end

  def paused()
    return @paused
  end

  def text()
    return @text+"\n"
  end

  def wait_for_input()
    cmd = ""
    loop do
      ch = STDIN.getch
      if ch.ord == 3 # (Ctrl + c)
        if @paused
          cmd = ""
          @paused = false
        else
          exit
        end

      end
      if ch == ":"
        @paused = true
        cmd = ""
        print "run: "
      else
        cmd += ch
        print ch if @paused
        if ch.ord == 13
          parse_cmd(cmd) if cmd.length > 1
          cmd = ""
          sleep(1)
          @paused = false
        end
      end
    end     
  end

  def parse_cmd(cmd)
    puts "command to execute: "+cmd
    if cmd.start_with?("text ")
      @text = cmd[5..-2]
    end
  end
end


iw = InputWaiter.new()

Thread.new { 
  iw.wait_for_input()
}

i = 0
loop do
  unless iw.paused()
    system("clear")
    printf iw.text(), i
    i += 1
  end
  sleep 1
end