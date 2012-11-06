
module Testdroid
	module Cloud
		class Clusters < CloudListResource
		end
		class Cluster < CloudResource
			def	initialize(uri, client, params= {})
				super uri, client,"cluster", params
				@uri, @client = uri, client
			end
		end
	end
end
