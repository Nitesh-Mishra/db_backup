require 'aws/s3'

class DbBackup
	@@host = 'localhost'
	@@port = 3306
	@@backup_path = ''
	@@db_username = ''
	@@db_password = ''
	@@db_name = ''
	@@s3_bucket  = ''
	@@aws_access_key = ''
	@@aws_secret_key  = '' 
	@@s3_region = ''

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

	def self.aws_access_key=(aws_access_key)
		@@aws_access_key = aws_access_key
	end

	def self.aws_access_key
		@@aws_access_key
	end

	def self.aws_secret_key=(aws_secret_key)
		@@aws_secret_key = aws_secret_key
	end

	def self.aws_secret_key
		@@aws_secret_key
	end

	def self.s3_bucket=(s3_bucket)
		@@s3_bucket = s3_bucket
	end

	def self.s3_bucket
		@@s3_bucket
	end

	def self.s3_region=(s3_region)
		@@s3_region = s3_region
	end

	def self.s3_region
		@@s3_region
	end

	def self.take_local_backup()
		begin
			if DbBackup.password && DbBackup.db_name	
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
			else
				puts "Some fields are missing. Check all the attributes."
			end		
		rescue
			puts "Check the database credentails or the name of the database which you want to backup."
		end
	end

	def self.backup_on_s3()
		begin
			if DbBackup.s3_region && DbBackup.s3_bucket && DbBackup.aws_secret_key && DbBackup.aws_access_key && DbBackup.db_name
				backup_filename = "#{Time.now.strftime("%d_%m_%Y_%H_%M")}_mysql_db.sql.gz"
				backup_filename_path = "/tmp/#{backup_filename}"

				system "mysqldump -P #{DbBackup.port} -h #{DbBackup.host} -u #{DbBackup.username} -p#{DbBackup.password} --databases #{DbBackup.db_name} | gzip > #{backup_filename_path}"
				
			    # save to aws-s3

			    AWS::S3::DEFAULT_HOST.replace "s3-#{@@s3_region}.amazonaws.com"
			    AWS::S3::Base.establish_connection!(:access_key_id     => "#{@@aws_access_key}", :secret_access_key => "@@aws_secret_key")
			    AWS::S3::S3Object.store(backup_filename, backup_filename_path, s3_bucket)

			    # remove local backup file
			    system "rm -f #{backup_filename_path}"
			else
				puts "Some aws credentails are missing."
			end			    
		rescue 
			puts "Check the aws credentails."
		end
	end

end
 