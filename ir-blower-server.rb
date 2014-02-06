#!/usr/bin/env ruby
# Author  : Brendan Horan
# License : BSD 3-Clause
# Version : 1.0.0
#
# Description :
# IR-blower server listens for commands from 
# clients (local or remote). 
# Server then acts on valid message and sends 
# signal to comm port defined in the config.
# This is then processed by the Arduino IR-Blower code.

# Requirements
require 'socket'
require 'syslog'
require 'yaml'
require 'serialport'


# Needs to run as root for now. 
# Could be made to use UUCP..
def checkuid
  uid = Process.uid
  if uid == 0
    read_config
  else
    puts "You need to be root to run the server"
    exit 2
  end
end


# Open syslog, to write messages and errors
Syslog.open


# Read in the config file
def read_config
  config = begin
    YAML.load_file("server-config.yaml")
    rescue ArgumentError => e
      puts "Could not parse YAML: #{e.message}"
  end
  @srvprt = config["server"]["listen_port"]
  @ttydev = config["server"]["tty_dev"]
end


# Run functions
checkuid
read_config


# Start the server 
$server = TCPServer.new @srvprt


# Open the connection to the serial port
def opentty
  begin
    File.chardev?("#{@ttydev}") == true
      $tty = SerialPort.open("#{@ttydev}", 9600, 8, 1,  SerialPort::NONE)
    rescue 
      Syslog.log(Syslog::LOG_ERR, "IR-Blower, Can't open TTY, exiting.")
      exit 2
    end
end


# Run the function
opentty


# Trap any exits and write to syslog
Syslog.log(Syslog::LOG_INFO, "IR-Blower starting on port : #{@srvprt}")

Signal.trap("TERM") do
  Syslog.log(Syslog::LOG_WARNING, "IR-Blower stopped")
  exit 2
end

Signal.trap("KILL") do
  Syslog.log(Syslog::LOG_ERR, "IR-BLower force killed")
  exit 2
end 

trap("INT") do
  STDERR.puts " IR-Blower killed"
  Syslog.log(Syslog::LOG_ERR, "IR-Blower got Crtl-C, Killed")
  exit 2
end


# List of functions that server expects to act on (client message)
def d1b1
  $tty.write "1"
end

def d1b2
  $tty.write "2"
end

def d1b3
  $tty.write "3"
end

def d1b4
  $tty.write "4"
end

def d1b5
  $tty.write "5"
end

def d1b6
  $tty.write "6"
end

def d2b1
  $tty.write "a"
end

def d2b2
  $tty.write "b"
end

def d2b3
  $tty.write "c"
end

def d2b4
  $tty.write "d"
end

def d2b5
  $tty.write "e"
end

def d2b6
  $tty.write "f"
end
  
def status(client)
  Thread.start (client) do |stat|
    stat.puts("OK")
  end  
end
    

# main processing loop, wait for incoming messages from clients.
# then jump to function based on client message
loop do
  Thread.start($server.accept) do |client|
  
  while ircommand  = client.gets

    command = ircommand.chomp
   
      case command 
  
        when "d1b1"
          d1b1()

        when "d1b2"
          d1b2()

        when "d1b3" 
          d1b3()

        when "d1b4"
          d1b4()

        when "d1b5"
          d1b5()
   
        when "d1b6"
          d1b6()

        when "d2b1"
          d2b1()
    
        when "d2b2"
          d2b2()

        when "d2b3"
          d2b3()

        when "d2b4"
          d2b4()

        when "d2b5"
          d2b5()

        when "d2b6"
          d2b6()

        when "status"
          status(client)

        else 
          Syslog.log(Syslog::LOG_ERR, "IR-BLower got invalid client option!")

      end 
    end
  end
end

# END
