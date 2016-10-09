### This gem helps you to easily create backups of the MYSQL Database and save it to the local system or on AWS S3.

### Getting Started

dbbackups3 only supports MySQL databases. Here are the steps to get you started:
- Install the gem by typing **gem install dbbackups3**
- Add `require "dbbackups3"` in your ruby file and use the following configuration to take the backup:
```
require 'dbbackups3'

db_backup = DbBackup.new
db_backup.host = "db_host"
db_backup.port = db_port
db_backup.username = "db_username"
db_backup.password = "db_password"
db_backup.db_name = "db_name"
```

### Backup on your local system
```
db_backup.backup_path = "db/backup/path"
db_backup.take_local_backup()
```

**Note :** Default backup path is - /home/username/backup/mysql_backup/

### Backup on AWS s3
```
db_backup.aws_access_key = 'aws_access_key'
db_backup.aws_secret_key  = 'aws_secret_key'
db_backup.s3_bucket  = 's3_bucket_name'
db_backup.s3_region = 'aws_region'

db_backup.backup_on_s3()

```


