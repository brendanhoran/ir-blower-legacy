#!/usr/bin/env ruby
# Author  : Brendan Horan
# License : BSD 3-Clause
# Version : 0.0.1


require 'socket'
require 'syslog'
require 'yaml'
require 'serialport'


def checkuid
  uid = Process.uid
  if uid == 0
    read_config
  else
    puts "You need to be root to run the server"
    exit 2
  end
end


Syslog.open


def read_config
  config = begin
    YAML.load_file("server-config.yaml")
    rescue ArgumentError => e
      puts "Could not parse YAML: #{e.message}"
  end
  @srvprt = config["server"]["listen_port"]
  @ttydev = config["server"]["tty_dev"]
end


checkuid
read_config


$server = TCPServer.new @srvprt


def opentty
  begin
    File.chardev?("#{@ttydev}") == true
      $tty = SerialPort.open("#{@ttydev}", 9600, 8, 1,  SerialPort::NONE)
    rescue 
      Syslog.log(Syslog::LOG_ERR, "IR-Blower, Can't open TTY, exiting.")
      exit 2
    end
end


opentty


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
      #stat.close
  end  
  end
    

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
