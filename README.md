# Small MySQL Backup Scripts with GPG and Restic 

**backupdump.sh**: mysqldump databases, encrypt them with gpg, backups the dump with restic.


**localimport.sh**: fetching the gpg-file via sftp, decrypt it and pipe it to mysql on a local machine

backupdump.sh could be running as a cronjob on the server. localimport.sh generates a local copy of the server database.

Use them, if you like.

We don't use "mysqldump | restic" because of the lower performance. It's recommended only, if your database is small (less "table lock" during dump) or if you use a master/slave replication of mysql where you could dump the slave database.
