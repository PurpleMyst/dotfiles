Journal
=======

A developer journal for solutions to problems

Firefox is too fullscreen
-------------------------

Set `full-screen-api.ignore-widgets` to `true` in `about:config`

Boot switch CFW on plug-in
--------------------------

```shell
$ echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0955", ATTRS{idProduct}=="7321", RUN+="/home/au/applications/fusee-launcher/run.sh"' | sudo tee /etc/udev/rules.d/fusee.rules
```

Electronics
-----------

general:
anode → electrons
cathode → ground

current flows from anode to cathode

some pages seem to say the opposite, i don't know why

LED: 
anode -> long
cathode -> ground

spud says that on a breadboard "+" must be Vcc and "-" must be GND
