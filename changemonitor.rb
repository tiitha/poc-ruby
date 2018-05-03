#!/usr/bin/env ruby

class ChangeMonitor

	def initialize(options)
		@options = options
	end

	def list_files()
		current_time = Time.new
		Dir.glob(@options['file_pattern']).each do |fn|
			change_time = File.mtime(fn)
			diff = ((current_time - change_time) / 1).to_i # minutes
			printf("%s\t%s bytes\t%s\n", fn.to_s, File.stat(fn).size.to_s.rjust(10), change_time.to_s) if diff < 1
		end
	end
end
