
module Testdroid
	module Cloud
		class DeviceRuns < CloudListResource
		end
		class DeviceRun < CloudResource
			def	initialize(uri, client, params= {})
				super uri, client,"deviceRun", params
				@uri, @client = uri, client
			end
		end
	end
end
