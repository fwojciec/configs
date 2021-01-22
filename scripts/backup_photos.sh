#!/bin/sh

SRC="/Volumes/Extreme SSD/Photos/Lightroom/Unprocessed Photos"
DEST="/Volumes/shared/Photos/Lightroom/Unprocessed Photos"

rsync -avz "$SRC"/* "$DEST"
