#!/usr/bin/env bash

# collection
# ---------------------------------------------------------------------

# restic variables

resrepo='-r sftp:127.0.0.1:/var/archiv/repos/base-dumps'
export RESTIC_PASSWORD_FILE="$HOME/.restic.pw"

last='20'
daily='7'
weekly='4'
monthly='6'
yearly='3'
limit='500'


restic snapshots $resrepo

# restic restore latest -r  $resrepo --target /

#
restic forget \
  --keep-last $last \
  --keep-daily $daily \
  --keep-last $weekly \
  --keep-monthly $monthly \
  --keep-yearly $yearly \
  --limit-upload $limit \
  --prune \
  $resrepo

# EOF
