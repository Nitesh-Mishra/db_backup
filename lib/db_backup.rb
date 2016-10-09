require 'aws/s3'

class DbBackup
	attr_accessor :username, :password, :backup_path, :db_name, :aws_access_key, :aws_secret_key, :s3_bucket, :s3_region
	attr_writer :host, :port

	def host
		@host || 'localhost'
	end

	def port
		@port || 3306
	end

	def take_local_backup()
		begin
			if @password && @db_name	
				if @backup_path.strip.empty?
					system "mkdir -p ~/backup/mysql_backup/#{Time.now.strftime("%d_%m_%Y_%H_%M")}"
					@backup_path = "~/backup/mysql_backup/#{Time.now.strftime("%d_%m_%Y_%H_%M")}/"
				else
					unless File.directory?(@backup_path.strip)
						puts "This path doesn't exist."
						puts "Try to use absolute path."
						return nil
					else
						path = @backup_path.strip
						unless path[-1] == "/"
							path += "/"
							@backup_path = path
						end
					end
				end
				system "mysqldump -P #{@port} -h #{@host} -u #{@username} -p#{@password} --databases #{@db_name} | gzip > #{@backup_path}#{Time.now.strftime("%d_%m_%Y_%H_%M")}_mysql_db.sql.gz"
				puts "Database backed up successfully."
			else
				puts "Some fields are missing. Check all the attributes."
			end		
		rescue
			puts "Check the database credentails or the name of the database which you want to backup."
		end
	end

	def backup_on_s3()
		begin
			if @s3_region && @s3_bucket && @aws_secret_key && @aws_access_key && @db_name
				backup_filename = "#{Time.now.strftime("%d_%m_%Y_%H_%M")}_mysql_db.sql.gz"
				backup_filename_path = "/tmp/#{backup_filename}"

				system "mysqldump -P #{@port} -h #{@host} -u #{@username} -p#{@password} --databases #{@db_name} | gzip > #{backup_filename_path}"
				
			    # save to aws-s3
			    AWS::S3::DEFAULT_HOST.replace "s3-#{@s3_region}.amazonaws.com"
			    AWS::S3::Base.establish_connection!(:access_key_id => @aws_access_key, :secret_access_key => @aws_secret_key)
			    AWS::S3::S3Object.store(backup_filename, backup_filename_path, @s3_bucket)
			    puts "Database backed up successfully."
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
 