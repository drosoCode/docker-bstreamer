# docker-bstreamer

Chrome embedded in a docker container with RTSP stream output (including audio and video) and remote debugging

## Configuration
### Environment Variables

| VAR            | Description                                                                     | Default Value                |
|----------------|---------------------------------------------------------------------------------|------------------------------|
| DISPLAY_WIDTH  | The display width (for xvfb, x11vnc and chrome)                                 | 1920                         |
| DISPLAY_HEIGHT | The display height                                                              | 1080                         |
| DISPLAY        | The display id                                                                  | :99                          |
| VNC            | Enable VNC server (needed if you want to use noVNC)                             | true                         |
| NOVNC          | Enable noVNC (to use vnc in a browser)                                          | true                         |
| REMOTE_DEBUG   | Enable chrome remote debugging (especially useful for puppeteer)                | true                         |
| RTSP_SERVER    | Use the built-in RTSP server (rtsp-simple-server)                               | true                         |
| ENABLE_VIDEO   | Enable video stream (if disabled, the rtsp stream only contains audio)          | true                         |
| RTSP_URL       | RTSP url for ffmpeg (change this only if you decide to use another RTSP server) | rtsp://localhost:8554/stream |

### Ports (inside the container)
| Service             | Port |
|---------------------|------|
| VNC                 | 5900 |
| noVNC               | 8080 |
| RTSP                | 8554 |
| CHROME_REMOTE_DEBUG | 9222 |

## Usage
Set your environment variables in the docker-compose file
run `docker-compose build` to build the container
run `docker-compose up -d` to run the container

You can open the RTSP stream on VLC with `rtsp://yourip:8554/stream`
You can interact with chrome with the noVNC server 
You can remotely control chrome in Node.js with [puppeteer-core](https://github.com/puppeteer/puppeteer)

## Softwares
This project uses the following softwares
 - [ffmpeg](https://github.com/FFmpeg/FFmpeg) to create the RTSP stream
 - [xserver (Xvfb)](https://gitlab.freedesktop.org/xorg/xserver) to create a xserver without display
 - [x11vnc](https://github.com/LibVNC/x11vnc) to allow remote interaction with the xserver
 - [noVNC](https://github.com/novnc/noVNC) and [websockify](https://github.com/novnc/websockify) to use vnc with a browser
 - [PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/) to create a virtual sound card
 - [rtsp-simple-server](https://github.com/aler9/rtsp-simple-server/) to serve the RTSP stream
 - [socat](http://www.dest-unreach.org/socat/) to allow to connect to chrome remote debugging from a remote pc
 
 
