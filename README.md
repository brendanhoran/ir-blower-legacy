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
