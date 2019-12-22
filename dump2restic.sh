#!/bin/sh

# mysql dump to restic
# ---------------------------------------------------------------------
# script will be called from dump2gpg.sh
#
# ssh connection: edit ~/.ssh/config and insert Hostname, User and Identity-File


# restic variables

RES_REPO="-r sftp:127.0.0.1:/var/archiv/repos/base-dumps"
export RESTIC_PASSWORD_FILE="sftp:127.0.0.1:/home/user/.restic.pw"
RES_TAG=$(date +'%Y-%m-%d')

DUMPFILE="$HOME/.dumps/base_data.sql"


# backup, check, forget

restic backup $DUMPFILE $RES_REPO --tag $RES_TAG --tag mysqldump

restic check $RES_REPO

restic forget \
  --keep-last 20 \
  --keep-daily 7 \
  --keep-weekly 4 \
  --keep-monthly 6 \
  --keep-yearly 3 \
  --limit-upload 100 \
  --prune \
  -r $RES_REPO

# EOF