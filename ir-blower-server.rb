#!/usr/bin/env ruby
# Author : Brendan Horan
# # Licence : BSD 3-Clause
# # Version : 0.0.1


require 'socket'
require 'syslog'

$srvprt = 2000

$server = TCPServer.new $srvprt

Syslog.open
Syslog.log(Syslog::LOG_INFO, "IR-Blower starting on port : #{$srvprt}")

Signal.trap("TERM") do
  Syslog.log(Syslog::LOG_WARNING, "IR-Blower stopped")
  exit
end

Signal.trap("KILL") do
  Syslog.log(Syslog::LOG_ERR, "IR-BLower force killed")
  exit
end 

  def volup

    puts "Vol up"

  end

  def voldown

    puts "Vol down"

  end

  def volmute

    puts "Vol mute"
 
  end
  

  loop do
    client = $server.accept
  
    while ircommand  = client.gets

    command = ircommand.chomp
   
    case command 
  
    when "vup"
      volup()

    when "vdn"
      voldown()

    when "mt" 
      volmute()

    else 
      puts 'We fucked up, bob'
    end 


end



  client.close


end
