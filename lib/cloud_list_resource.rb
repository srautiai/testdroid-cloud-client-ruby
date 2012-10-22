
module Testdroid
	module Cloud
		class CloudListResource
		
			def initialize(uri, client)
				puts "initialize list - #{uri}, #{client} "
				@uri, @client = uri, client
				resource_name = self.class.name.split('::')[-1]
				@instance_class = Testdroid::Cloud.const_get resource_name.chop
				puts "ints.c lass - #{@instance_class}"
				@list_key, @instance_id_key = resource_name, 'id'
			end
			def get(resource_id)
				puts "ints.c lass - #{@instance_class}  #{resource_id} #{@client} #{@uri} "
				@instance_class.new( "#{@uri}/#{resource_id}", @client)
			end
			def list(params={}, full_uri=false)
				raise "Can't get a resource list without a REST Client" unless @client
				response = @client.get @uri
				#puts "response from list - #{@list_key} - #{response}" 
				#resources = response[@list_key]
				#uri = full_uri ? @uri.split('.')[0] : @uri
				#resource_list = resources.map do |resource|
				if response.is_a?(Array) 
					#puts "Is array"
					response.each do |val|
						
						@instance_class.new "#{@uri}/#{val[@instance_id_key]}", @client, val
					end
				end
				
			end
		end
	end
end
