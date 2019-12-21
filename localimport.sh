#!/bin/sh

# Importing encrypted mysql dumps
# ---------------------------------------------------------------------
# "pv" is a tool to display the piped bytes in MB/sec
# Set password for mysql in ~/.my.cnf
# Set password for sftp with ssh-keygen
# Set password for gpg in ~/.gnupg/example-passwd

# sftp source
SOURCE="127.0.0.1:/var/archiv"
# local target dir
DUMPDIR="$HOME"
# encrypted dump file name
DUMPFILE="base_data.sql.gpg"
# local path and file
DUMP="$DUMPDIR/$DUMPFILE"
# password file
PWFILE="$HOME/.gnupg/base-passwd"

clear
date
echo "# fetch $DUMPFILE"

sftp $SOURCE/$DUMPFILE $DUMPDIR


if [ -f "$DUMP" ]
then

    echo "# decrypt $DUMPFILE and pipe to mysql"

    cat $PWFILE | gpg2 --passphrase-fd 0 --batch --decrypt $DUMP | pv | mysql

    rm $DUMP

fi

# EOF