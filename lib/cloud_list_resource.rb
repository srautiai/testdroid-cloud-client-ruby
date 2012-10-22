
module Testdroid
	module Cloud
		class CloudListResource
			def initialize(uri, client)
			 @uri, @client = uri, client
			 resource_name = self.class.name.split('::')[-1]
			 @instance_class = Testdroid::Cloud.const_get resource_name.chop
			@list_key, @instance_id_key = resource_name, 'sid'
			end
			def get(resource_id)
				@instance_class.new "#{@uri}/#{resource_id}", @client
			end
			def list(params={}, full_uri=false)
				raise "Can't get a resource list without a REST Client" unless @client
				response = @client.get @uri, params, full_uri
				resources = response[@list_key]
				uri = full_uri ? @uri.split('.')[0] : @uri
				resource_list = resources.map do |resource|
				  @instance_class.new "#{uri}/#{resource[@instance_id_key]}", @client, resource
				end
				
			end
		end
	end
end
