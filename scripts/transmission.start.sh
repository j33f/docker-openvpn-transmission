#!/bin/sh

trsettings="/transmission/settings.json"

echo "Configuring Transmission..."
if [ -f "$trsettings" ];
then
    echo "Custom configuration found."
else
    echo "No settings file found, using default one."
    # Configuring Transmission username/password
    if [ -z ${TRANSMISSIONUSERNAME+x} ];
    then
        echo "No user name set for Transmission..."
        TRANSMISSIONUSERNAME=$(date +%s | sha256sum | base64 | head -c 32 ; echo)
        echo "Setting it to ${TRANSMISSIONUSERNAME}"
    fi

    if [ -z ${TRANSMISSIONPASSWORD+x} ];
    then
        echo "No password set for Transmission..."
        sleep 1
        TRANSMISSIONPASSWORD=$(date +%s | sha256sum | base64 | head -c 32 ; echo)
        echo "Setting it to ${TRANSMISSIONPASSWORD}"
    fi

    cp /settings/transmission.json $trsettings

    sed -e "s/#rpc-username#/$TRANSMISSIONUSERNAME/" $trsettings
    sed -e "s/#rpc-password#/$TRANSMISSIONPASSWORD/" $trsettings
fi

echo "Setting Transmission IP bindings"
sed -e "s/#bind-address-ipv4#/$4/" $trsettings

echo "Here is the Transmission configuration used:"

cat $trsettings

echo ""

echo "Launch Transmission."
exec /usr/bin/transmission-daemon -g /transmission