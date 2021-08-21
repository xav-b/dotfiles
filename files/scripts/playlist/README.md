# Playlist downloader

## Installation (Mac OSX)

```
brew install ffmpeg
brew install youtube-dl
```

## Usage

```
# download one video
./dl.sh ef898fs9fwe

# download a user-defined list of videos
# 1 stands for audio quality, from 0 to 9 (best to worst, default to 5)
./dl-all.sh playlist.txt 1

# your mp3s are in `./downloads`
ls downloads/
```
