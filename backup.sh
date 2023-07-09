#!/usr/bin/env bash
# Syncs S3 with the local machine

# Set variables
HOST=$(hostname -s | tr '[:upper:]' '[:lower:]')
LOCAL_ROOT="/Users/karlmartin"
BUCKET="s3://$HOST-archive"

# Directory paths are relative to $LOCAL_ROOT
declare -a PATHS=("Documents" "dev")

backup() {

    # Backup selected directories in $HOME
    for DIR in "${PATHS[@]}"
    do
        printf "\nBacking up $DIR to $BUCKET/$DIR Please wait..\n"

        aws s3 sync $LOCAL_ROOT/$DIR "$BUCKET/$DIR" \
        --exclude "*.DS_Store" \
        --exclude "*.localized" \
        --exclude "*git*" \
        --storage-class DEEP_ARCHIVE

        printf "\nBackup of $DIR to $BUCKET/$DIR complete.\n"
    done

    # Backup select files in $HOME
    aws s3 cp "$LOCAL_ROOT/.zshrc" $BUCKET
    aws s3 cp "$LOCAL_ROOT/.vimrc" $BUCKET
}

backup
