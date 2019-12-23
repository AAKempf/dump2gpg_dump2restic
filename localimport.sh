#!/usr/bin/env bash

# Importing encrypted mysql dumps
# ---------------------------------------------------------------------
# "pv" is a tool to display the piped bytes in MB/sec
# Set password for mysql in ~/.my.cnf
# Set password for sftp with ssh-keygen
# Set password for gpg in ~/.gnupg/dump-passwd

# config
# sftp source
source='127.0.0.1:/var/archiv'
# local target dir
dumpdir=$HOME
# encrypted dump file name
dumpfile='server.sql.gpg'
# local path and file
dump="$dumpdir/$dumpfile"
# password file
pwfile="$HOME/.gnupg/dump-passwd"

# start
clear
date
echo "# fetch $dumpfile"
sftp $source/$dumpfile $dumpdir

if [ -f "$dump" ]
then

  echo "# decrypt $dumpfile and pipe to mysql"
  cat $pwfile | gpg2 --passphrase-fd 0 --batch --decrypt $dump | pv | mysql
  rm $dump

fi
date
# EOF