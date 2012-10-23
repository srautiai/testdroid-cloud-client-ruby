module Testdroid
	module Cloud
		class Runs < CloudListResource
		end
		class Run < CloudResource
			def	initialize(uri, client, params= {})
				super uri, client,"run", params
				@uri, @client = uri, client
			end
		end
	end
end