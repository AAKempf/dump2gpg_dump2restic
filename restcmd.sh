#!/bin/sh

# collection
# ---------------------------------------------------------------------

# restic variables

RES_REPO="sftp:127.0.0.1://var/archiv/repos/base-dumps"
export RESTIC_PASSWORD_FILE="$HOME/.restic.pw"

KEEP_LAST="20"
KEEP_DAILY="7"
KEEP_WEEKLY="4"
KEEP_MONTHLY="6"
KEEP_YEARLY="3"
LIMIT_UPLOAD="500"


restic snapshots -r $RES_REPO

# restic restore latest -r  $RES_REPO --target /

#
restic forget \
  --keep-last $KEEP_LAST \
  --keep-daily $KEEP_DAILY \
  --keep-weekly $KEEP_WEEKLY \
  --keep-monthly $KEEP_MONTHLY \
  --keep-yearly $KEEP_YEARLY \
  --limit-upload $LIMIT_UPLOAD \
  --prune \
  -r $RES_REPO

# EOF
