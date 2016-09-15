# Eddystone UID for Linux

This is a script I hacked together based on Google's Eddystone URL beacon script. URL beacons
require the user to have a special app installed, where as UID beacons supposedly show up for
everyone who has Google Play Services installed and bluetooth on. The usage is kinda rough right
now. You must have `hcitool` installed, which is in the `bluez` package on debian and presumably
similarly named packages on other distros. Next, generate the message payload with the `genmsg.py`
script in this repo:

```bash
./genmsg.py example.org 000000
```

Use a domain you own if possible. The first ten bytes of the sha1 has of the sum of the domain are
used as the identifier for all of your beacons, and the six characters after that are used as an
identifier for this beacon in particular. The output will be a string of hexadecimal pairs. Make
note of it, we'll use it in a second.

The next step is to bring up the bluetooth device and stop any beaconing it might currently be
doing:

```bash
hciconfig hci0 up
hcitool cmd 0x08 0x000a 00
```

Now comes the fun part! Set the message, using the string of hex from earlier where `$msg` is:

```bash
hcitool cmd 0x08 0x0008 $msg
```

Finally, turn the beaconing back on:

```bash
hcitool cmd 0x08 0x000a 01
```

The `example.sh` script in this repo will do all of this.
