#!/bin/bash
# from: https://askubuntu.com/questions/852477/how-do-i-stop-audio-clicking-popping-over-spdif
# from: https://wiki.archlinux.org/title/PulseAudio/Troubleshooting#Choppy/distorted_sound
# works for me on 2022-06-02


{
  echo "avoid-resampling = yes";
  echo "enable-remixing = yes";
  echo "default-sample-rate = 48000"
} >> /etc/pulse/daemon.conf
