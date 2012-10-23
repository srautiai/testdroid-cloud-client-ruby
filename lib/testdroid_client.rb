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
				  #puts "#{auth_header} - #{uri} "
				  
				  resp = RestClient.get(@cloud_url+"#{uri}",auth_header)
				  JSON.parse(resp)
			end
			def post(uri, resource_name, params={}) 
				  auth_header =  get_auth_header(@username, @api_key ,random_string(), resource_name)
				  #puts "#{auth_header} - #{uri} "
				  auth_header['Accept'] = 'application/json'
				  begin 
				  	resp = RestClient.post(@cloud_url+"/#{API_VERSION}#{uri}",params, auth_header)
				  rescue => e
				  	$stderr.puts  e
				  end
				  #puts resp
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
					@cloud_user = Testdroid::Cloud::User.new( "/#{API_VERSION}", self, authorize() )
				end
				@cloud_user
			end
			def get_auth_header(client, apikey,nonce, resourceName)
				digestdata = apikey+":"+nonce+":"+resourceName
				digest = Digest::SHA256.hexdigest(digestdata)

				 {'X-Testdroid-Authentication' => client+" "+nonce+" "+digest}
			end
			
			def authorize() 
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

