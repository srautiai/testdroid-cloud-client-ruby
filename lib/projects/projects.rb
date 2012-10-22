
module Testdroid
	module Cloud
		class Projects < CloudListResource
		end
		class Project < CloudResource
		
			def	initialize(uri, client, params= {})
				
				super uri, client,"project", params
				
				puts "init called #{uri}-#{client}- #{params}"
				@uri, @client = uri, client
			end
		end
	end
end
