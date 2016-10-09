### This gem helps you to easily create backups of the MYSQL Database and save it to the local system or on AWS S3.

### Getting Started

db_back_up only supports MySQL databases. Here are the steps to get you started:
- Install the gem by typing **gem install db_back_up**
- Add `require "db_backup"` in your ruby file and use the following configuration to take the backup:
```
require 'db_backup'

db_backup = DbBackup.new
db_backup.host = "db host"
db_backup.port = db port
db_backup.username = "db username"
db_backup.password = "db password"
db_backup.db_name = "database name"
```

### Backup on your local system
```
db_backup.backup_path = "backup path"
db_backup.take_local_backup()
```

**Note :** Default backup path is - /home/username/backup/mysql_backup/

### Backup on AWS s3
```
db_backup.aws_access_key = 'aws access key'
db_backup.aws_secret_key  = 'aws secret key'
db_backup.s3_bucket  = 's3 bucket name'
db_backup.s3_region = 'aws region'

db_backup.backup_on_s3()

```


