#!/usr/bin/env ruby

require './xtail'

def parse_event(evt)
	puts "+ "+evt
end

options = {
	'buffer_size' => 8192,
	'delimiter' => "\n",
	'file_pattern' => "/Users/tiitha/projects/logs/*test*.log"
}

tailer = Xtail.new(options)

loop do
	events = tailer.get_events()
	events.each { |e| parse_event(e) }
	sleep(0.1)	
end