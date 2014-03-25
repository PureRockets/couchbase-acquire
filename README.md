couchbase-acquire
=================

Data Acquisition with Couchbase Logging

This project demonstrates how do acquire sensor data with an Aruduino-style device and log the data in real-time using a Couchbase data store. Either a PC, Linux or Mac system can be used to install Couchbase and the UDP/wireless listener. Other embedded devices (such as the Arduino YUN or Raspberry Pi) can be used instead of the Wasmmote presented here. Generally look for the WiFi Examples in your IDE, and look for a UDP example. I was able to easily capture 100 samples per second with static data. The acquisition of the Waspmote accelerometer is limited to approximately 10 samples per second. You can view the data flowing into Couchbase in real time using the web admin UI.

In this demo, I'm using the Waspmote device from Libelium. The Waspmote is a commercial/low power Arduino-style device. 10 times per second, the running app reads the accelerometer data and broadcasts the data in JSON format for direct write into the Couchbase node. Couchbase does not enforce a JSON schema, so the JSON output of the device can be changed on the fly if needed, with no other changes needed. The new JSON format will simply flow into Couchbase. It's also possible to program the Waspmote remotely, so it would be possible to have a "swarm" of devices, easily sync'd and writing to Couchbase. Such an application might be used in industrial automation/monitoring of the factory floor workflow, for example, or where ever remote sensing with logging is required.

Prerequisites:

* Install Couchbase server from http://www.couchbase.com/download
* Install node.js from nodejs.org



Steps:

* Install Couchbase
* Create a new bucket called acquire-demo
* Obtain the IP address from your Couchbase host system which will also be running the UDP listener
* Edit UDP_Couchbase.js with the IP address above. Feel free to use Port 33333 or another port
* Edit UDP_Couchbase.pde and upate the ip address to the above, and the ESSID and AUTHKEY values for your local wireless network.
* Using the Waspmote IDE, upload this file to the Device. Once connected to the local network after 10 seconds or so, the green led with light, showing a connection.
* Press the reset button on the Waspmote to restart
* While the Waspmote is restarting, start the node application on the host system: $> node UDP_Couchbase.js
* The app is now listening for the UDP broadcast.
* Once connected, the Waspmote is now broadcasting the Accelerometer data via UDP several times per second
* The host app is reading the UDP data, and writing to the local Couchbase node
* Launch the Couchbase Web Admin UI and browse to the acquire-demo bucket. You should see about 10 ops per second


