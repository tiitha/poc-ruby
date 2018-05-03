# poc-ruby
POC scripts and other testing scripts written in ruby
## changemonitor.rb
'changemonitor.rb' looks for file changes based on the file pattern (mtime of the file and alerts file changes). Can be used for unwanted file changes in certain folders etc or in a reversed way (e.g. to check if log file is not being appended for a while)
## nonblock.rb
'nonblock.rb' enables me to interact with already running processes, e.g. manipulate dictionary content of my running scripts
## xtail.rb
'tail -f' functionality implemented in ruby that enables you to tail multiple files simultaniously based on a file pattern. Script scans the changes on your disk based on the pattern and adds (or removes) the respective files. In other words - the files you want to monitor might not exist yet.
