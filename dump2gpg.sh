#!/bin/sh

# dump mysql, encrypt, call restic script
# ---------------------------------------------------------------------
# Script runs on the server in a cronjob


# config

DUMPDIR="$HOME/.dumps"
DUMPFILE="base_data.sql"
SAVEDIR="$HOME/mybackup"

DB1="geodata"
DB2="production"
DB3="ads_log"

SQLOPT="--opt --disable-keys --databases $DB1 $DB2 $DB3"

PWFILE="$HOME/.gnupg/base-passwd"

# dump
mysqldump $SQLOPT > $DUMPDIR/$DUMPFILE

# encrypt, compress, creates $DUMPFILE.gpg
cat $PWFILE | gpg -c --batch --passphrase-fd 0 $DUMPDIR/$DUMPFILE

# Restic saves the DUMPFILE only, not the encrypted .gpg
./dumps2restic.sh

# Move encrypted to another dir
mv $DUMPDIR/$DUMPFILE.gpg $SAVEDIR/$DUMPFILE.gpg

# remove dump
rm $DUMPDIR/$DUMPFILE


# EOF