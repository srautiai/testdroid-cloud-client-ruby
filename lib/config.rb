module Testdroid
	module Cloud
		class Config < CloudResource
		
			def	initialize(uri, client, params= {})
				
				super uri, client,"projectConfig", params
				
				@uri, @client = uri, client
			end
		end
	end
end
