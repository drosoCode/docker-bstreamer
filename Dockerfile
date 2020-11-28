FROM debian:10

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    RTSP_URL="rtsp://localhost:8554/stream" \
    DISPLAY_WIDTH=1920 \
    DISPLAY_HEIGHT=1080 \
    DISPLAY=:99 \
    VNC=true \
    NOVNC=true \
    REMOTE_DEBUG=true \
    RTSP_SERVER=true \
    ENABLE_VIDEO=true

RUN apt-get update && \
    apt-get install -y \
    --no-install-recommends \
    socat \
    novnc \
    supervisor \
    x11vnc \
    xvfb \
    pulseaudio \
    ffmpeg \
    wget \
    gnupg

RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >>  /etc/apt/sources.list.d/dl_google_com_linux_chrome_deb.list && \
    wget https://dl.google.com/linux/linux_signing_key.pub && \
    apt-key add linux_signing_key.pub && \
    apt-get update && apt-get install -y google-chrome-stable

RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

WORKDIR /home
RUN wget https://github.com/aler9/rtsp-simple-server/releases/download/v0.12.2/rtsp-simple-server_v0.12.2_linux_amd64.tar.gz
RUN tar -xzf rtsp-simple-server_v0.12.2_linux_amd64.tar.gz && rm rtsp-simple-server_v0.12.2_linux_amd64.tar.gz
COPY rtsp-simple-server.yml rtsp-simple-server.yml

COPY supervisord.conf /etc/supervisord.conf
COPY pulseaudio.sh pulseaudio.sh
COPY stream.sh stream.sh
RUN chmod +x pulseaudio.sh stream.sh rtsp-simple-server

CMD ["supervisord", "-c", "/etc/supervisord.conf"]