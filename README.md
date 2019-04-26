Traffic Shaping DGA4132
=======================

[![Latest Stable Version](https://img.shields.io/github/release/xMase/Traffic-Shaping-DGA4132.svg)](https://github.com/xMase/Traffic-Shaping-DGA4132)
[![Downloads](https://img.shields.io/github/downloads/xMase/Traffic-Shaping-DGA4132/total.svg)](https://github.com/xMase/Traffic-Shaping-DGA4132)
[![Repo Size](https://img.shields.io/github/repo-size/xMase/Traffic-Shaping-DGA4132.svg)](https://github.com/xMase/Traffic-Shaping-DGA4132)
[![License](https://img.shields.io/github/license/xMase/Traffic-Shaping-DGA4132.svg)](https://github.com/xMase/Traffic-Shaping-DGA4132)

 
It is a useful script to easily configure traffic shaping on Tim DGA4132 (***TimHub***)<br>
This script uses **qdisc** with **htb** as traffic shaper and **sfq** as queuing disciplines.

**To avoid incompatibility with the technicolor standard QoS it will be disabled once it is installed and re-enabled upon uninstallation.**

***it is highly recommended to disable ipv6.***

Installation
============

Download **[setup.sh](https://github.com/xMase/Traffic-Shaping-DGA4132/releases/latest)** to /tmp directory, change permissions with **chmod + x /tmp/setup.sh** and run it.

Configuration
=============

Change the **test** configuration located in **/etc/config/mshaper**

I remember that:

- **eth0** ... **eth3** => are the ethernet interfaces
- **eth5** => is the 5Ghz wifi interface
- **wl0** => is the 2.4Ghz wifi interface

in the class section:

- **downlink** => upload 
- **uplink** => download

An **interface** can have **more class** and **each class** can have **multiple ip/mac filters** that manage the available bandwidth.

```ini
# 5Ghz wifi interface
config interface 'eth5' 
    # max interface upload  
    option 'tot_dl' '3000kbit'
    # max interface download 
    option 'tot_up' '30000kbit'
    # list of classes added to this interface
    list class '7mb'
    # ...
    
# 2.4Ghz wifi interface same as before
config interface 'wl0'  
    # maximum upload for the filters of this class, 
    # this value is optional 
    # if not added will take the total upload value of the interface
    option 'tot_dl' '3000kbit' 
    # maximum download for the filters of this class, 
    # this value is optional 
    # if not added will take the total download value of the interface
    option 'tot_up' '30000kbit'
    list class '7mb'
    # ...

# class that limits the filters 
config class '7mb' 
    option 'dl' '324kbit'
    option 'ul' '7000kbit'  
    # list of filters added to this class
    list filter 'tv'
    list filter 'tablet'
    # ...

# filter based on the mac
config filter 'tv'     
    option 'mac' '01:01:01:01:01:01'

#ip based filter
config filter 'tablet'
    option 'ip' '192.168.1.25'
    # IPv4 Subnet Calculator
    # https://www.calculator.net/ip-subnet-calculator.html
    option 'subnetmask' '32'
```

Usage
=====

Default operations:

- /etc/init.d/mshaper **enable**  => to enable the script ***on starup***
- /etc/init.d/mshaper **start** => to start the script
- /etc/init.d/mshaper **stop** => to stop the script
- /etc/init.d/mshaper **disable** => to disable the script ***on starup***

Debug:

- **logread** => to read mshaper log

Contribute code
===============

If you have any **ideas**/**solutions**/**improvements** to be included in this project, **feel free to submit a pull request**.