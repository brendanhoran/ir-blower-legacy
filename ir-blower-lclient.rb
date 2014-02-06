#!/usr/bin/env ruby
# Author  : Brendan Horan
# License : BSD 3-Clause
# Version : 1.0.0
#
# Connects to the local ir-blower server
# on port 2000 and sends an option to the server.
# For example you can use this from CRON to turn 
# on a device via IR blower server.


# requires
require 'socket'


# Check to see if a command line option was supplied
if ARGV.length < 1
  puts "Require IR blower option" 
end


# Open a connection to the server (running local)
lblower = TCPSocket.new 'localhost', 2000


# Send client option to server and print response if any.
lblower.puts ARGV.first
  response = lblower.gets.strip
  puts "Response: " + response
lblower.close
