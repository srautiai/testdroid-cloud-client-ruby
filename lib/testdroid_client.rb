#!/usr/bin/ruby

#require './testdroid_cloud/version.rb'

module Testdroid

	module Cloud
		class Client
			API_VERSION = '1.0'
			CLOUD_ENDPOINT='https://cloud.testdroid.com'
			USERS_ENDPOINT='https://users.testdroid.com'
			def initialize(username, password, cloud_url=CLOUD_ENDPOINT, users_url=USERS_ENDPOINT, api_key = nil)  
				# Instance variables  
				@username = username  
				@password = password  
				@cloud_url = cloud_url
				@users_url = users_url
				@api_key = api_key
				
			end   
			def get(uri) 
				  auth_header =  get_auth_header(emailAdd, @api_key ,random_string(), "projects")
				  puts "#{auth_header} - #{uril} - #{args[0]} - #{args[1]}"
				  resp = RestClient.get(CLOUD_ENDPOINT+"#{uril}",auth_header)
				  JSON.parse(resp)
			  end

			def random_string(length=6)
				chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
				password = ''
				length.times { password << chars[rand(chars.size)] }
				password
			end
			def get_user
				if (@cloud_user.nil?)
					@cloud_user = Testdroid::Cloud::User.new( "/#{API_VERSION}/abc", self, authorize() )
				end
				@cloud_user
			end
			def get_auth_header(client, apikey,nonce, resourceName)
				digestdata = apikey+":"+nonce+":"+resourceName
				digest = Digest::SHA256.hexdigest(digestdata)

				 {'X-Testdroid-Authentication' => client+" "+nonce+" "+digest}
			end
			def set_up_subresources # :doc:
				#@user = Twilio::REST::Accounts.new "/#{API_VERSION}/Accounts", self
				#@account = @accounts.get @account_sid
			end
			#Get user projects from testdroid cloud
			def get_projects() 
				 
				
				 auth_header =  get_auth_header(emailAdd, @api_key ,random_string(), "projects")

			
				resp = RestClient.get_content(CLOUD_ENDPOINT+"/api/v1/projects", nil, auth_header)
				resp
			end
			def authorize() 
				body = { "email"=>@username , "password"=>@password}
				header = { 'Accept' => 'application/json' }
				resp = RestClient.post(USERS_ENDPOINT+"/api/v1/authorize", body, header)
				
				if(resp.nil?) 
					abort( "No response")
				end
				user = JSON.parse(resp)
				if(user.nil?) 
					$stderr.puts "Couldn't authorize" 
					return nil
				end
				@api_key =  user['secretApiKey']
				user
			end
		
		end
	end
end


