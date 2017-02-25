#!/bin/sh
echo "Transmission over openvpn starting"

# Configuring VPN
vpnconf="/vpn.conf" vpnauth="/vpn.auth" vpnorigconf="/conf.ovpn"

if [ -f "$vpnorigconf" ];
then
    if [ -z ${OVPNUSERNAME+x} ];
    then
        echo "No user name set for vpn..."
        exit 1
    fi
    if [ -z ${OVPNPASSWORD+x} ];
    then
        echo "No password set for vpn..."
        exit 1
    fi
else
    echo "Please provide a configuration file for vpn"
    exit 1
fi

cat $vpnorigconf > $vpnconf
echo "auth-user-pass $vpnauth" >> $vpnconf
echo "$OVPNUSERNAME" > $vpnauth
echo "$OVPNPASSWORD" >> $vpnauth
chmod 0600 $vpnauth

# Launch Openvpn
exec openvpn --config $vpnconf --script-security 2 --up /scripts/transmission.start.sh --down /scripts/transmission.stop.sh