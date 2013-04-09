#!/usr/bin/ruby

#require './testdroid_cloud/version.rb'

module Testdroid

	module Cloud
		class Client
			API_VERSION = 'api/v1'
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
			def get(uri, resource_name) 
				
				  auth_header =  get_auth_header(@username, @api_key ,random_string(), resource_name)
				  begin 
					resp = RestClient.get(@cloud_url+"#{uri}",auth_header)
				  rescue => e
					$stderr.puts "Failed to get resource #{resource_name} #{e}"
					return nil
				  end
				  JSON.parse(resp)
		  end
		  def download(uri, resource_name, file_name)
				auth_header =  get_auth_header(@username, @api_key ,random_string(), resource_name)
				auth_header['Accept'] = 'application/json'
				File.open(file_name, "w+b") do |file|
			   file.write(RestClient.get("#{uri}",auth_header))
			end
		  end
			def post(uri, resource_name, params={}) 
				  auth_header =  get_auth_header(@username, @api_key ,random_string(), resource_name)
				  auth_header['Accept'] = 'application/json'
				  begin 
				  	resp = RestClient.post(@cloud_url+"/#{API_VERSION}#{uri}",params, auth_header)
				  rescue => e
				  	$stderr.puts  e
				  	return nil
				  end
				  JSON.parse(resp)
			end
			def upload(uri,u_id, filename) 
				  
				digest = Digest::MD5.hexdigest(File.read(filename))
				
				auth_header = get_auth_header(@username, @api_key ,random_string(),  "upload#{u_id}application#{digest}")	
				auth_header['Accept'] = 'application/json'
				auth_header['X-Testdroid-MD5'] = digest
				begin 
					response = RestClient.post(@cloud_url+"/#{API_VERSION}#{uri}",  {:file => File.new(filename), :multipart => true,  }, auth_header)
				 rescue => e
				  	$stderr.puts  e
				  	return nil
				end
				JSON.parse(response)
			end
			def random_string(length=6)
				chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
				password = ''
				length.times { password << chars[rand(chars.size)] }
				password
			end
			def get_user
				if (@cloud_user.nil?)
					@cloud_user = Testdroid::Cloud::User.new( "/#{API_VERSION}", self, authenticate() )
				end
				@cloud_user
			end
			def get_auth_header(client, apikey,nonce, resourceName)
				digestdata = apikey+":"+nonce+":"+resourceName
				digest = Digest::SHA256.hexdigest(digestdata)

				 {'X-Testdroid-Authentication' => client+" "+nonce+" "+digest}
			end
			
			def authenticate() 
				body = { "email"=>@username , "password"=>@password}
				header = { 'Accept' => 'application/json' }
				resp = RestClient.post(@users_url+"/api/v1/authorize", body, header)
				
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


