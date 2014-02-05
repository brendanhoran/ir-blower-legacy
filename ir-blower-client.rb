#!/usr/bin/env ruby
# Author  : Brendan Horan
# License : BSD 3-Clause
# Version : 0.0.1

require 'gtk2'
require 'socket'
require 'yaml'


def read_config
  config = begin
    YAML.load_file("client-config.yaml")
    rescue ArgumentError => e
      puts "Could not parse YAML: #{e.message}"
  end
  @srvhst = config["client"]["server_ip"] 
  @srvprt = config["client"]["server_port"]
  @actdev = config["client"]["default_dev"]
  @d1name = config["device1"]["name"]
  @d1btn1 = config["device1"]["button1"]
  @d1btn2 = config["device1"]["button2"]
  @d1btn3 = config["device1"]["button3"]
  @d1btn4 = config["device1"]["button4"]
  @d1btn5 = config["device1"]["button5"]
  @d1btn6 = config["device1"]["button6"]
  @d2name = config["device2"]["name"]
  @d2btn1 = config["device2"]["button1"]
  @d2btn2 = config["device2"]["button2"]
  @d2btn3 = config["device2"]["button3"]
  @d2btn4 = config["device2"]["button4"]
  @d2btn5 = config["device2"]["button5"]
  @d2btn6 = config["device2"]["button6"]
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



# Taskbar icon
vt=Gtk::StatusIcon.new
vt.pixbuf=Gdk::Pixbuf.new('sys-icn.png')
vt.tooltip='Volume Control'


# left click pop up app
vt.signal_connect('activate'){

  def d1
 
 $server = TCPSocket.new @srvhst, @srvprt

  vbox = Gtk::VBox.new(false, 0)
  vollab = Gtk::Label.new("Volume Options :")
  vollab.set_alignment(0,0)
  hbox0 = Gtk::HBox.new(false, 0)
  hbox1 = Gtk::HBox.new(false, 0)
  hbox2 = Gtk::HBox.new(false, 0)
  hbox3 = Gtk::HBox.new(false, 0)
  hbox4 = Gtk::HBox.new(false, 0)
  hboxinl = Gtk::HBox.new(false, 0)
  inlab = Gtk::Label.new("Input Options :")
  inlab.set_alignment(0,0)
  hboxpl = Gtk::HBox.new(false, 0)
  pwlab = Gtk::Label.new("Power Options :")
  pwlab.set_alignment(0,0)
  
 sep1 = Gtk::HSeparator.new
 sep2 = Gtk::HSeparator.new

  btn1 = Gtk::Button.new(@d1btn1)
  btn1.signal_connect("clicked") {
    $server.puts "d1b4"

  }  

  btn2 = Gtk::Button.new(@d1btn2)
  btn2.signal_connect("clicked") {
    $server.puts "d1b5"
  }

  btn3 = Gtk::Button.new(@d1btn3)
  btn3.signal_connect("clicked") {
    $server.puts "d1b3"
  }

  btn4 = Gtk::Button.new(@d1btn4)
  btn4.signal_connect("clicked") {
    $server.puts "d1b1"
  }

  btn5 = Gtk::Button.new(@d1btn5)
  btn5.signal_connect("clicked") {
    $server.puts "d1b2"
  }

  btn6 = Gtk::Button.new(@d1btn6)
  btn6.signal_connect("clicked") {
    $server.puts "d1b6"
  }



  window = Gtk::Window.new
  window.title = "#{@d1name}"
  hbox0.pack_start vollab, true, true, 0
  hbox1.pack_start btn1, true, true, 0
  hbox1.pack_start btn2, true, true, 0
  hbox2.pack_start btn3, true, true, 0
  hboxinl.pack_start inlab, true, true, 0
  hbox3.pack_start btn4, true, true, 0
  hbox3.pack_start btn5, true, true, 0
  hboxpl.pack_start pwlab, true, true, 0
  hbox4.pack_start btn6, true, true, 0
  vbox.pack_start hbox0, true, true, 3
  vbox.pack_start hbox1, true, true, 0
  vbox.pack_start hbox2, true, true, 0
  vbox.pack_start sep1, true, true, 5
  vbox.pack_start hboxinl, true, true, 3
  vbox.pack_start hbox3, true, true, 0
  vbox.pack_start sep2, true, true, 5
  vbox.pack_start hboxpl, true,true, 3
  vbox.pack_start hbox4, true, true, 0 
  
  window.add(vbox)

  window.border_width = 10
  window.show_all

  window.signal_connect('delete_event') { Gtk.main_quit }
  window.signal_connect('destroy') { Gtk.main_quit }
  Gtk.main
  $server.close
  end

  def d2
 
  $server = TCPSocket.new @srvhst, @srvprt
  
 
  vbox = Gtk::VBox.new(false, 0)
  hbox1 = Gtk::HBox.new(false, 0)
  hbox2 = Gtk::HBox.new(false, 0)
  hbox3 = Gtk::HBox.new(false, 0)
  hbox4 = Gtk::HBox.new(false, 0)
  sep1 = Gtk::HSeparator.new
  inlab = Gtk::Label.new("Select input :")
  inlab.set_alignment(0,0)
  galab = Gtk::Label.new("Set Gain :")
  galab.set_alignment(0,0)

  btn1 = Gtk::Button.new(@d2btn1)
  btn1.signal_connect("clicked") {
    $server.puts "d2b6"

  }
  
  

  in1 = Gtk::RadioButton.new("#{@d2btn2}")
  in1.signal_connect("clicked") {
    $server.puts "d2b1", @actin = 1 if in1.active?
  }
  in2 = Gtk::RadioButton.new(in1, "#{@d2btn3}")
  in2.signal_connect("clicked") {
    $server.puts "d2b4", @actin = 2 if in2.active?
  }
  in3 = Gtk::RadioButton.new(in1, "#{@d2btn4}")
  in3.signal_connect("clicked") {
    $server.puts "d2b5", @actin = 3 if in3.active?
  }
  in4 = Gtk::RadioButton.new(in1, "#{@d2btn5}")
  in4.signal_connect("clicked") {
    $server.puts "d2b2", @actin = 4 if in4.active?
  }
  in5 = Gtk::RadioButton.new(in1, "#{@d2btn6}")
  in5.signal_connect("clicked") {
    $server.puts "d2b3", @actin = 5 if in5.active?
  }

    case @actin
    when 1
      in1.set_active true
    when 2
      in2.set_active true
    when 3
      in3.set_active true
    when 4
      in4.set_active true
    when 5
      in5.set_active true
    else
    end 

  window = Gtk::Window.new
  window.title = "#{@d2name}"
  hbox1.pack_start galab, true, true, 0
  hbox1.pack_start btn1, true, true, 0
  hbox2.pack_start in1, true, true, 0
  hbox3.pack_start in2, true, true, 0
  hbox3.pack_start in3, true, true, 0
  hbox4.pack_start in4, true, true, 0
  hbox4.pack_start in5, true, true, 0
  vbox.pack_start hbox1, true, true, 0
  vbox.pack_start sep1, true, true, 5
  vbox.pack_start inlab, true, true, 3
  vbox.pack_start hbox2, true, true, 0
  vbox.pack_start hbox3, true, true, 0
  vbox.pack_start hbox4, true, true, 0
  window.add(vbox)
  window.border_width = 10
  window.show_all

  window.signal_connect('delete_event') { Gtk.main_quit }
  window.signal_connect('destroy') { Gtk.main_quit }
  Gtk.main
  $server.close
  end


case @actdev
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

  case @actdev
  when 1
   @name = @d1name
  when 2
   @name = @d2name
  else 
   @name = "unknown"
  end
   
  $server = TCPSocket.new @srvhst, @srvprt
  $server.write( "status\n" )
  $server.flush
  srvmsg = $server.gets
  if srvmsg.strip == "OK"
    $stat = "Connected"
  else
    $stat = "ERROR"
  end
  $server.close
 
  info = Gtk::Window.new
  
  info.title = "Information"

  title = Gtk::Label.new("Using server/port :")
  title.set_alignment(0,0)
  srvip = Gtk::Label.new(" #{@srvhst}:#{@srvprt} ")
  devstr = Gtk::Label.new("Current Device :")
  devstr.set_alignment(0,0)
  curdev = Gtk::Label.new(" #{@name} ")
  srvmsg = Gtk::Label.new("Server connection :")
  srvmsg.set_alignment(0,0)
  srvstat = Gtk::Label.new(" #{$stat} ")

 
  vbox = Gtk::VBox.new(false, 0) 
  hbox1 = Gtk::HBox.new(false, 0)
  hbox2 = Gtk::HBox.new(false, 0)
  hbox3 = Gtk::HBox.new(false, 0)
  hbox1.pack_start title, true, true, 0
  hbox1.pack_start srvip, true, true, 0
  hbox2.pack_start devstr, true, true, 0
  hbox2.pack_start curdev, true, true, 0
  hbox3.pack_start srvmsg, true, true, 0
  hbox3.pack_start srvstat, true, true, 0
  

  info.signal_connect('delete_event') { Gtk.main_quit }

  vbox.pack_start hbox1, true, true, 0
  vbox.pack_start hbox2, true, true, 0
  vbox.pack_start hbox3, true, true, 0
  info.add(vbox)
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

  # set the active btn from last state
    case @actdev
    when 1
      dev1.set_active true      
    when 2
      dev2.set_active true
    else
    end

  
  vbox = Gtk::VBox.new(false, 5)
  vbox.pack_start(desc)
  vbox.pack_start(dev1, false, true, 0)
  vbox.pack_start(dev2, false, true, 0)

  window.add(vbox)
  window.show_all

  dev1.signal_connect("clicked") { @actdev = 1 if dev1.active? }
  dev2.signal_connect("clicked") { @actdev = 2 if dev2.active? }
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
