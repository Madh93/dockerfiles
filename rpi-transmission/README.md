# rpi-transmission

Custom Transmission dockerfile for Raspberry Pi based on [https://github.com/koukihai/rpi-alpine-transmission](https://github.com/koukihai/rpi-alpine-transmission).

### Installation

    git clone https://github.com/Madh93/dockerfiles && cd dockerfiles/rpi-transmission

### Usage

Build image and create default container:

    ./install.sh

To change default container name or torrents directory (`/home/pi/Torrent`) check out the installation script before to launch.

Modify `settings.json` to access from remote host:

    {
        "download-dir": "/app/completed",
        "incomplete-dir": "/app/incomplete",
        "incomplete-dir-enabled": true,
        "rpc-whitelist": "127.0.0.1,YOUR_CUSTOM_IP",
        "rpc-whitelist-enabled": false
    }
