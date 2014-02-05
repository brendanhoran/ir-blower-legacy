require 'socket'

$server = TCPSocket.new( "127.0.0.1", 2000 )
$server.write( "status\n" )
$server.flush
srvmsg = $server.gets
  if srvmsg.strip == "OK"
      $stat = "Connected"
    else
      $stat = "ERROR"
end
  puts $stat
$server.close
