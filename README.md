StdExample
==========

StdExample is simple example of standard io plugin for Nagome written in ruby/gtk3.

It just prints the event to left text area and can send Nagome messages from right text area.

You can easily modify "subscribe" in "plugin.yml" file to change the event type you want to receive.

Requirement
-----------

* ruby-gtk3

You can install using following command on Ubuntu.

```
sudo apt install ruby-gtk3
```

### Install

```
cd PLUGIN_DIR
git clone https://github.com/diginatu/nagome-stdexample.git
```

PLUGIN_DIR is a "plugin" directory in the Nagome save path which can be found in the result of `nagome -h`.
