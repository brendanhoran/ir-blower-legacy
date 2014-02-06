IR-Blower
=========

IR-Blower consists of four parts.

* A GTK2 desktop client (written in Ruby/GTK) [Systray app + GUI window]
* An optional command line client
* A Server (written in Ruby)
* A hardware control (Written for Arduino)


The concept for the IR-Blower project is simple.
Control a remote device via its inbuilt IR sensor from a desktop app running on a PC.
Must be able to work in a Client/Server mode across local LAN's.


Hear is a [screenshot of the current UI](http://cache.horan.hk/images/ir-blower-ui-v1.0.png).

Dependencys
-------------

1. Ruby

  List of gems:
  * socket
  * syslog
  * gtk2
  * yaml
  * serialport

2. GTK2 support on your system.
3. Arduino hardware / code

Install guide
-------------

1. Upload Arduino sketch to your arduino device.
2. Place the file ir-blower-server.rb on the computer to act as the IR blower server.(arduino attached)
3. Edit the server-config.yaml file to meet your needs and place it on the IR blower server.
4. Edit the ir-blower-server.rb file to updat the location of the config file :
   " YAML.load_file("server-config.yaml") "
5. Place the file ir-blower-client.rb on to your desktop system
6. Place the fil esys-icn.png in the same location as the ir-blower-client.rb file
7. Edit the client-config.yaml file to meet your needs
8. Edit the ir-blower-client.rb file to update the location of the config file :
   " YAML.load_file("server-config.yaml") "
9. Start the server as backbround process, then start the client on your pc.

Optionally you can use the ir-blower-lclient.rb to send commands to the server , from the server via the command line.
For example you could have a cron entry that sends a button click for example :
05 00 * * * ir-blower-lclient.rb d1b6 > /dev/null 2>&1

This would at 5am send the button press "d1b6" to the server.


