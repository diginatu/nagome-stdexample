# read and write std in gui
require 'gtk3'

class RubyApp < Gtk::Window

    def initialize
        super

        STDOUT.sync = true
        init_ui
    end

    def init_ui
        set_title "std test"
        signal_connect "destroy" do 
            Gtk.main_quit 
        end


        @textin = Gtk::TextView.new
        @textin.set_editable(false)
        @textin.set_wrap_mode(:char)
        @textin.signal_connect("size-allocate") do |_, _, _|
            @scrwinin.vadjustment.value = 
                @scrwinin.vadjustment.upper - @scrwinin.vadjustment.page_size
        end
        @textout = Gtk::TextView.new
        @textout.set_wrap_mode(:char)
        @textout.buffer.signal_connect "insert-text" do |_, _, t, _|
            print t
        end

        @scrwinin = Gtk::ScrolledWindow.new
        @scrwinin.border_width = 5
        @scrwinin.add(@textin)
        @scrwinin.set_policy(:automatic, :always)

        @scrwinout = Gtk::ScrolledWindow.new
        @scrwinout.border_width = 5
        @scrwinout.add(@textout)
        @scrwinout.set_policy(:automatic, :always)

        grid = Gtk::Grid.new
        grid.set_property "row-homogeneous", true
        grid.set_property "column-homogeneous", true

        grid.attach @scrwinin, 0, 0, 1, 1
        grid.attach @scrwinout, 1, 0, 1, 1

        add grid

        set_default_size 500, 500
        set_window_position :center

        show_all
    end

    def addTextToStdin s
        @textin.buffer.text += s
    end
end

Gtk.init
app = RubyApp.new

t = Thread.new do
    STDIN.each do |line|
        app.addTextToStdin(line)
    end
    Gtk.main_quit
end

Gtk.main

t.join
