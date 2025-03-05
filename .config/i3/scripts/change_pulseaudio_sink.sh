#!/bin/bash

# headphones_name="alsa_output.usb-Razer_Razer_Kraken_X_USB_00000000-00.analog-stereo"
# speaker_name="alsa_output.pci-0000_0b_00.4.analog-stereo"
#
# sinks=$(pactl list sinks)
# running_string="State: RUNNING"
#
# sed -n "/$running_string/ { n; p }" <<< "$sinks" #| grep "$headphones_name"

pulseaudio-control --node-blacklist "alsa_output.platform-snd_aloop.0.analog-stereo,alsa_output.pci-0000_09_00.1.hdmi-stereo" next-node
