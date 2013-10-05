#!/usr/bin/env ruby
# Author : Brendan Horan
# Licence : BSD 3-Clause
# Version : 0.0.1

require 'gtk2'
require 'socket'
require 'yaml'

@d = 1

def read_config
  config = begin
    YAML.load_file("client-config.yaml")
    rescue ArgumentError => e
      puts "Could not parse YAML: #{e.message}"
  end
  @srvhst = config["client"]["server_ip"] 
  @srvprt = config["client"]["server_port"]
  @d1name = config["device1"]["name"]
  @d1btn1 = config["device1"]["button1"]
  @d1btn2 = config["device1"]["button2"]
  @d1btn3 = config["device1"]["button3"]
  @d2name = config["device2"]["name"]
  @d2btn1 = config["device2"]["button1"]
  @d2btn2 = config["device2"]["button2"]
  @d2btn3 = config["device2"]["button3"]
end

read_config


trap("TERM") do
  STDERR.puts "IR-Blower Client stopped"
  exit 2
end

trap("KILL") do
  STDERR.puts "IR-BLower Client force killed"
  exit 2
end 

trap("INT") do
  STDERR.puts " IR-Blower Client got Crtl-C, Killed"
  exit 2
end


$server = TCPSocket.new @srvhst, @srvprt

# Taskbar icon
vt=Gtk::StatusIcon.new
vt.stock=Gtk::Stock::DIALOG_INFO
vt.tooltip='Volume Control'


# left click pop up app
vt.signal_connect('activate'){

  def d1

  table = Gtk::Table.new(2, 2, true)

  btn1 = Gtk::Button.new(@d1btn1)
  btn1.signal_connect("clicked") {
    $server.puts "d1b1"

  }  

  btn2 = Gtk::Button.new(@d1btn2)
  btn2.signal_connect("clicked") {
    $server.puts "d1b2"
  }

  btn3 = Gtk::Button.new(@d1btn3)
  btn3.signal_connect("clicked") {
    $server.puts "d1b3"
  }


  window = Gtk::Window.new
  window.title = "Volume Control"
  table.attach_defaults(btn1, 0, 1, 0, 1)
  table.attach_defaults(btn2, 1, 2, 0, 1)
  table.attach_defaults(btn3, 0, 2, 1, 2)
  window.add(table)
  window.border_width = 10
  window.show_all

  window.signal_connect('delete_event') { Gtk.main_quit }
  window.signal_connect('destroy') { Gtk.main_quit }
  Gtk.main
  end

  def d2

  table = Gtk::Table.new(2, 2, true)

  btn1 = Gtk::Button.new(@d2btn1)
  btn1.signal_connect("clicked") {
    $server.puts "d2b1"

  }  

  btn2 = Gtk::Button.new(@d2btn2)
  btn2.signal_connect("clicked") {
    $server.puts "d2b2"
  }

  btn3 = Gtk::Button.new(@d2btn3)
  btn3.signal_connect("clicked") {
    $server.puts "d2b3"
  }


  window = Gtk::Window.new
  window.title = "DAC Control"
  table.attach_defaults(btn1, 0, 1, 0, 1)
  table.attach_defaults(btn2, 1, 2, 0, 1)
  table.attach_defaults(btn3, 0, 2, 1, 2)
  window.add(table)
  window.border_width = 10
  window.show_all

  window.signal_connect('delete_event') { Gtk.main_quit }
  window.signal_connect('destroy') { Gtk.main_quit }
  Gtk.main
  end


case @d
  when 1
    d1()
  when 2
    d2()
  else
    puts "No Device Selected"
  end
}


# create the right click menu (info item)
info=Gtk::ImageMenuItem.new(Gtk::Stock::INFO)
info.signal_connect('activate'){

  def status
 
  info = Gtk::Window.new
  table = Gtk::Table.new(2, 3, true)
  
  info.border_width = 10
  info.title = "Information"

  title = Gtk::Label.new("Using server :")
  srvip = Gtk::Label.new(" #{@srvhst}:#{@srvprt} ")
  curdev = Gtk::Label.new("current dev")

  

  info.signal_connect('delete_event') { Gtk.main_quit }

  table.attach_defaults(title, 0, 1, 0, 1)
  table.attach_defaults(srvip, 1, 2, 0, 1)
  table.attach_defaults(curdev,0, 1, 2, 3)
  info.add(table)
  info.border_width = 10
  info.show_all
  Gtk.main
  end

  status()
}

devsel=Gtk::ImageMenuItem.new("Device?")
devsel.signal_connect('activate'){

  def devseclt()
   
   
  window = Gtk::Window.new(Gtk::Window::TOPLEVEL)
  window.set_title  "Select Device"
  window.border_width = 10
  window.signal_connect('delete_event') { Gtk.main_quit }
  desc = Gtk::Label.new(" Select a device to control:")

  dev1 = Gtk::RadioButton.new("#{@d1name}")
  dev2 = Gtk::RadioButton.new(dev1, "#{@d2name}")

  vbox = Gtk::VBox.new(false, 5)
  vbox.pack_start(desc)
  vbox.pack_start(dev1, false, true, 0)
  vbox.pack_start(dev2, false, true, 0)

  window.add(vbox)
  window.show_all

  dev1.signal_connect("clicked") { @d = 1 if dev1.active? }
  dev2.signal_connect("clicked") { @d = 2 if dev2.active? }
  Gtk.main

  end


  devseclt()

}


# create the right click quit menu item
quit=Gtk::ImageMenuItem.new(Gtk::Stock::QUIT)
quit.signal_connect('activate'){ Gtk.main_quit }
menu=Gtk::Menu.new
menu.append(devsel)
menu.append(Gtk::SeparatorMenuItem.new)
menu.append(info)
menu.append(Gtk::SeparatorMenuItem.new)
menu.append(quit)
menu.show_all


# build the right click menu
vt.signal_connect('popup-menu'){|tray, button, time| menu.popup(nil, nil, button, time)}


# Main app
Gtk.main
$server.close
