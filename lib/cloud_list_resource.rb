
module Testdroid
	module Cloud
		class CloudListResource
		
			def initialize(uri, client)
				@uri, @client = uri, client
				resource_name = self.class.name.split('::')[-1]
				@instance_class = Testdroid::Cloud.const_get resource_name.chop
				@list_key, @instance_id_key = resource_name.gsub!(/\b\w/) { $&.downcase } , 'id'
			end
			def get(resource_id)
				@instance_class.new( "#{@uri}/#{resource_id}", @client)
			end
			def list(params={}, full_uri=false)
				raise "Can't get a resource list without a REST Client" unless @client
				response = @client.get( @uri, @list_key)
				
				if response.is_a?(Array) 
					class_list = response.each do |val|
						@instance_class.new "#{@uri}/#{val[@instance_id_key]}", @client, val
					end
				end
				class_list
			end
		end
	end
end
