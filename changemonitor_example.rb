#!/usr/bin/env ruby
require './changemonitor'

options = {
	'file_pattern' => "/var/log/*"
}

cm = ChangeMonitor.new(options)

loop do
	cm.list_files()
	sleep(1)
end