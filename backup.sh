#!/usr/bin/env bash
# Syncs S3 with the local machine

# Set variables
HOST=$(hostname -s | tr '[:upper:]' '[:lower:]')
LOCAL_ROOT="/Users/karlmartin/"
BUCKET="s3://$HOST-archive"

backup() {
    printf "\nBacking up $LOCAL_ROOT to $BUCKET. Please wait..\n"

    aws s3 sync $LOCAL_ROOT $BUCKET \
    --exclude "*" \
    --include ".zshrc" \
    --include ".vimrc" \
    --include "Documents/*"\
    --include "dev/*" \
    --exclude "*.DS_Store" \
    --exclude "*.localized" \
    --exclue "*git*" \
    --storage-class DEEP_ARCHIVE \

    printf "\nBackup of $LOCAL_ROOT to $BUCKET complete.\n"
}

backup
