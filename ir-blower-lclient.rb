#!/usr/bin/env ruby
# Author  : Brendan Horan
# License : BSD 3-Clause
# Version : 0.0.1
#
# Connects to the local ir-blower server
# on port 2000 and sends an option to the server.
# For example you can use this from CRON to turn 
# on a device via IR blower server.

require 'socket'


if ARGV.length < 1
  puts "Require IR blower option" 
end

lblower = TCPSocket.new 'localhost', 2000

lblower.puts ARGV.first
lblower.close
