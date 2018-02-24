#!/usr/bin/env ruby
class Xtail
	def initialize(options)
		@options = options
		@sources = {}
		@initial = true
		@delim_len = @options['delimiter'].length
	end

	def find_files()
		# check existing files in sources and remove obsolete ones
		@sources.each { |fn,p|
			@sources.delete(fn) if not File.exist?(fn)
		}

		# check for new files in filesystem and add them to sources
		Dir.glob(@options['file_pattern']).each { |fn|
			position = 0

			# when starting the script, set the positions to the end of the file (tail -f)
			position = File.stat(fn).size if @initial
			@sources[fn] = position unless @sources.has_key?(fn)
		}
		@initial = false
	end

	def get_events()
		find_files()
		events = []
		@sources.each { |fn,p|
			f = File.new(fn)
			f.seek(p)

			buf = f.read(@options['buffer_size'])
			next if buf == nil

			i = buf.rindex(@options['delimiter'])
			next if i == nil

			events += buf[0,i].split(@options['delimiter'])

			@sources[fn] += i + @delim_len
		}
		return events
	end

end
