# Docker container for Transmission via openvnp

This a 5MB alpine based container including Tranmission torrent client and OpenVPN client to be used via docker-compose.
It has been made to be used with .ovpn files including certificates (like ones given by ExpressVPN).

## Usage 

The best way to use this container is to use it with docker-compose (see [docker-compose example](https://github.com/j33f/docker-openvpn-transmission/blob/master/docker-compose%20example))

Read the docker-compose.yml file and edit it following your needs:
- [#22](https://github.com/j33f/docker-openvpn-transmission/blob/master/docker-compose%20example/docker-compose.yml#L22): set the path to your .ovpn file (containing the certificates)
- [#23](https://github.com/j33f/docker-openvpn-transmission/blob/master/docker-compose%20example/docker-compose.yml#L23): set the path where all the torrents folders will be:
    - /downloads
    - /incomplete
    - /watch
- [#24](https://github.com/j33f/docker-openvpn-transmission/blob/master/docker-compose%20example/docker-compose.yml#L24): set the path to your own transmission settings.json file (there is one under the [settings folder](https://github.com/j33f/docker-openvpn-transmission/blob/master/settings) /!\ read below)

The [settings folder](./settings) contains:
- a ready to use nginx.conf file (you may consider to change the ```listen 8080``` line to another port)
- an editable settings file for transmission
    - /!\ do not edit the ```#bind-address-ipv4#``` placeholder!
    - set a user name and password at lines [#46](https://github.com/j33f/docker-openvpn-transmission/blob/master/settings/transmission.json#L46) and [#47](https://github.com/j33f/docker-openvpn-transmission/blob/master/settings/transmission.json#L47)
    - /!\ read [the Transmission settings documentation prior to tweak](https://github.com/transmission/transmission/wiki/Editing-Configuration-Files)

### First launch

Use the following command: 
``` 
docker-compose -f /path/to/the/docker-compose.yml up
```

Look at the logs to see if anything wrong is happening.

If everything looks ok, type your server address at port 8080 (or the port you specified for nginx configuration): you should be invited to type a login and a password then access to the Transmission web interface.

## Lisense

Copyright 2017 Jean-François Vial

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
