class DbBackup
	@@host = 'localhost'
	@@port = 3306
	@@backup_path = ''
	@@db_username = ''
	@@db_password = ''
	@@db_name = ''
	@@socket = ''
	@@s3_bucket  = ''
	@@aws_access_key = ''
	@@aws_secret_key  = ''


	def self.host=(hostname)
		@@host = hostname
	end

	def self.host
		@@host
	end

	def self.port=(port)
		port = port
	end

	def self.port
		@@port
	end

	def self.username=(db_username)
		@@db_username = db_username
	end

	def self.username
		@@db_username
	end

	def self.password=(db_password)
		@@db_password = db_password
	end

	def self.password
		@@db_password
	end

	def self.backup_path=(backup_path)
		@@backup_path = backup_path
	end

	def self.backup_path
		@@backup_path
	end

	def self.db_name=(db_name)
		@@db_name = db_name
	end

	def self.db_name
		@@db_name
	end

	def self.take_local_backup()
		if DbBackup.backup_path.strip.empty?
			system "mkdir -p ~/backup/mysql_backup/#{Time.now.strftime("%d_%m_%Y")}"
			DbBackup.backup_path = "~/backup/mysql_backup/#{Time.now.strftime("%d_%m_%Y")}/"
		else
			path = DbBackup.backup_path
			unless File.directory?(path)
				puts "This path doesn't exist."
				puts "Try to use absolute path."
				return nil
			else
				unless path.strip[-1] == "/"
					path.strip << "/"
				end
			end
		end
		system "mysqldump -P #{DbBackup.port} -h #{DbBackup.host} -u #{DbBackup.username} -p#{DbBackup.password} --databases #{DbBackup.db_name} | gzip > #{DbBackup.backup_path}#{Time.now.strftime("%d_%m_%Y_%H_%M")}_mysql_db.sql.gz"
		puts "Database backed up successfully."
	end

	def self.backup_on_s3()

	end

end
