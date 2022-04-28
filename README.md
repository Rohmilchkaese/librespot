# librespot
librespot docker image - based on Alpine Linux

Link to [Docker Hub](https://hub.docker.com/r/rohmilkaese/librespot)

[Librespot](https://github.com/librespot-org/librespot/) is an open source client library for Spotify. It enables applications to use Spotify's service to control and play music via various backends, and to act as a Spotify Connect receiver. It is an alternative to the official and now deprecated closed-source libspotify. Additionally, it will provide extra features which are not available in the official library.


## Docker Run

Command:

```bash
sudo docker run -it --net=host -v '/tmp/librespot:/tmp/librespot' rohmilkaese/librespot:latest --disable-audio-cache --name 'Verteiler' --device-type 'avr' --bitrate 320 --username 'user.email@domain.tld' --password 'Password' --backend 'pipe' --device '/tmp/librespot/fifo'
```