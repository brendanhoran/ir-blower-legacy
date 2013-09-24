#!/usr/bin/env ruby
# Author : Brendan Horan
# Licence : BSD 3-Clause
# Version : 0.0.1

require 'gtk2'
require 'socket'

$srvhst = 'localhost'
$srvprt = '2000'

$server = TCPSocket.new $srvhst, $srvprt

# Taskbar icon
vt=Gtk::StatusIcon.new
vt.stock=Gtk::Stock::DIALOG_INFO
vt.tooltip='Volume Control'


# left click pop up app
vt.signal_connect('activate'){

  def mainvol

  table = Gtk::Table.new(2, 2, true)

  volUbtn = Gtk::Button.new("Volume Up")
  volUbtn.signal_connect("clicked") {
    $server.puts "vup"

  }  

  volDbtn = Gtk::Button.new("Volume Down")
  volDbtn.signal_connect("clicked") {
    $server.puts "vdn"
  }

  volmute = Gtk::Button.new("Mute")
  volmute.signal_connect("clicked") {
    $server.puts "mt"
  }


  window = Gtk::Window.new
  window.title = "Volume Control"
  table.attach_defaults(volUbtn, 0, 1, 0, 1)
  table.attach_defaults(volDbtn, 1, 2, 0, 1)
  table.attach_defaults(volmute, 0, 2, 1, 2)
  window.add(table)
  window.border_width = 10
  window.show_all

  window.signal_connect('delete_event') { Gtk.main_quit }
  window.signal_connect('destroy') { Gtk.main_quit }
  Gtk.main
  end

  mainvol()
}


# create the right click menu (info item)
info=Gtk::ImageMenuItem.new(Gtk::Stock::INFO)
info.signal_connect('activate'){

  def status
 
  info = Gtk::Window.new
  table = Gtk::Table.new(2, 2, true)
  
  info.border_width = 10
  info.title = "Information"

  title = Gtk::Label.new("Using server :")
  srvip = Gtk::Label.new(" #{$srvhst}:#{$srvprt} ")
  srvst = Gtk::Label.new("res")
  

  info.signal_connect('delete_event') { Gtk.main_quit }

  table.attach_defaults(title, 0, 1, 0, 1)
  table.attach_defaults(srvip, 1, 2, 0, 1)
  info.add(table)
  info.border_width = 10
  info.show_all
  Gtk.main
  end
  
  status()
}


# create the right click quit menu item
quit=Gtk::ImageMenuItem.new(Gtk::Stock::QUIT)
quit.signal_connect('activate'){ Gtk.main_quit }
menu=Gtk::Menu.new
menu.append(info)
menu.append(Gtk::SeparatorMenuItem.new)
menu.append(quit)
menu.show_all


# build the right click menu
vt.signal_connect('popup-menu'){|tray, button, time| menu.popup(nil, nil, button, time)}


# Main app
Gtk.main
$server.close
