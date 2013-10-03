IR-Blower
=========

IR-Blower consists of three parts.

* A GTK2 desktop client (written in Ruby/GTK) [Systray app + GUI window]
* A Server (written in Ruby)
* A hardware control (Written for Arduino)


The concept for the IR-Blower project is simple.
Control a remote device via its inbuilt IR sensor from a desktop app running on a PC.
Must be able to work in a Client/Server mode across local LAN's.

This is still very much a work in progress.

Hear is a [screenshot of the current UI](http://cache.horan.hk/images/ir-blower-ui-v0.0.1.png).

Dependencys
-------------

1. Ruby

  List of gems:
  * socket
  * syslog
  * gtk2
  * yaml

2. GTK2 support on your system.
3. Arduino hardware / code
