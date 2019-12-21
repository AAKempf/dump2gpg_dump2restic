# Small MySQL Backup Scripts with GPG and Restic 

1. dump2gpg.sh: mysqldump databases and encrypt them with gpg, which call 
2. dump2restic.sh to backup the dump.
3. localimport.sh: fetching the gpg-file via sftp, decrypt it and pipe it to mysql on a local machine

Scripts 1) and 2) could be running as cronjobs on the server. Script 3) is for a local copy of the server databases.

Use them, if you like.

We don't use "mysqldump | restic" because of the lower performance. It's recommended only, if your database is small (less "table lock" during dump) or if you use a master/slave replication of mysql where you could dump the slave database.
