pulseaudio -D --exit-idle-time=-1
pacmd load-module module-virtual-sink sink_name=v1 latency_msec=1
pacmd load-module module-virtual-source source_name=VirtualInput latency_msec=1
pacmd set-default-sink v1
pacmd set-default-source VirtualInput