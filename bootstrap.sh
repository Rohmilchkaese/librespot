#!/bin/bash

librespot --name ${LIBRESPOT_DEVICE_NAME} -b 320 -u ${SPOTIFY_USERNAME} -p ${SPOTIFY_PASSWORD} -enable-volume-normalisation --initial-volume 75 --backend ${SPOTIFY_AUDIO_BACKEND}