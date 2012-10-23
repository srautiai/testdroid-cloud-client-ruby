module Testdroid
	module Cloud
		class Runs < CloudListResource
		end
		class Run < CloudResource
			def	initialize(uri, client, params= {})
				super uri, client,"run", params
				@uri, @client = uri, client
				sub_items :device_runs
			end
		end
	end
end
