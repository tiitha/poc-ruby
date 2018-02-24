#!/usr/bin/env ruby

Log_pattern = "/logs/data_[0-9]/*/*.access.log"
Buffer_size = 8192
Delimiter = "\n"
Delim_len = Delimiter.length

$sources = {}
$initial = true


def scan_folder()

	# check existing files in sources and remove obsolete ones
	$sources.each { |fn,p|
		$sources.delete(fn) if not File.exist?(fn)
	}

	# check for new files in filesystem and add them to sources
	Dir.glob(Log_pattern).each { |fn|
		position = 0

		# when starting the script, set the positions to the end of the file (tail -f)
		position = File.stat(fn).size if $initial
		$sources[fn] = position unless $sources.has_key?(fn)
	}
	$initial = false
end

def follow()
	loop do
		scan_folder()
		$sources.each { |fn,p|
			f = File.new(fn)
			f.seek(p)

			buf = f.read(Buffer_size)
			next if buf == nil

			i = buf.rindex(Delimiter)
			next if i == nil

			events = buf[0,i].split(Delimiter)

			events.each { |e| parse_event(e) }

			$sources[fn] += i + Delim_len
		}
		sleep(0.1)	
	end
end

def parse_event(evt)
	puts "+ "+evt
end

follow()
