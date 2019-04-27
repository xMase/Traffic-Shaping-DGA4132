#!/bin/sh  

if [ "$1" == "install" ]; then 

    # stop and disable technicolor qos
    /etc/init.d/qos stop
    /etc/init.d/qos disable

    # /etc
    if [ -f "/etc/config/mshaper" ]; then 
        mv "/etc/config/mshaper" "/etc/config/mshaper.old"
    fi

    cp -rf /tmp/mShaper/etc/* /etc/    

    if [ -f "/etc/config/mshaper.old" ]; then
        mv "/etc/config/mshaper.old" "/etc/config/mshaper"
    fi

    chmod +x "/etc/hotplug.d/iface/10-mshaper"
    chmod +x "/etc/init.d/mshaper"

    # /usr
    cp -rf /tmp/mShaper/usr/* /usr/
           
    chmod +x "/usr/bin/mshaper"
    chmod +x "/usr/bin/tc"

elif [ "$1" == "uninstall" ]; then

    # stop and disable mshaper    
    /etc/init.d/mshaper stop
    /etc/init.d/mshaper disable

    # /etc/
    rm "/etc/hotplug.d/iface/10-mshaper"
    rm "/etc/init.d/mshaper"

    # /usr/
    rm "/usr/bin/mshaper"
    rm "/usr/bin/tc"

    # enable techicolor qos
    /etc/init.d/qos enable
    
else 
    echo "mShaper easy setup:"
    echo ""
    echo "setup.sh [ install | uninstall ]"
    echo ""
    echo "install => to install mShaper"
    echo "uninstall => to uninstall mShaper"
    echo ""
    echo "**please note that the mShaper configuration will not be removed from the uninstallation proces**"
fi