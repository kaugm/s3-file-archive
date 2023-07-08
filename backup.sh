#!/usr/bin/env bash
# Syncs S3 with the local machine

# Set variables
HOST=$(hostname -s)
LOCAL_ROOT="/Users/martk"
BUCKET="s3://$HOST-archive"

backup() {
    printf "\nBacking up $DIR. Please wait..\n"

    aws s3 sync $DIR $BUCKET \
    --exclude "*" \
    --include "Desktop/*"
    --exclude "*.DS_Store" \
    --exclude "*.localized" \
    --storage-class DEEP_ARCHIVE \

    printf "\nBackup of $DIR complete.\n"
}

backup