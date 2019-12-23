#!/usr/bin/env bash

# dump mysql, encrypt and, backup with restic
# ---------------------------------------------------------------------
# Script runs on the server in a cronjob


# config
# ---------------------------------------------------------------------
dumpdir="$HOME/.dumps"
dumpfile='server.sql'
savedir="$HOME/myarchiv/"

databases=(geodata production ads_log)

sqlopt="--opt --disable-keys --databases ${databases[*]}"

pwfile="$HOME/.gnupg/dump-passwd"

resrepo='-r sftp:127.0.0.1:/var/archiv/repos/base-dumps'
restag=$(date +'%Y-%m-%d')
export RESTIC_PASSWORD_FILE="$HOME/.restic.pw"

# start
# ---------------------------------------------------------------------
# dump
mysqldump $sqlopt > $dumpdir/$dumpfile

# encrypt, compress, creates $dumpfile.gpg
cat $pwfile | gpg -c --batch --passphrase-fd 0 $dumpdir/$dumpfile

# Move encrypted file to another dir
mv $dumpdir/$dumpfile.gpg $savedir/$dumpfile.gpg

# Restic saves the dumpfile
restic backup $dumpdir/$dumpfile $resrepo --tag $restag --tag mysqldump

# remove dump
rm $dumpdir/$dumpfile


# EOF