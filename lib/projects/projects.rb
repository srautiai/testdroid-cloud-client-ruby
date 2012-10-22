
module Testdroid
	module Cloud
		class Projects < CloudListResource
		end
		class Project < CloudResource
		
			def	initiliaze(uri, client, params= {})
				super uri, client, params
				puts "init called #{uri}-#{client}- #{params}"
				@uri, @client = uri, client
			end
		end
	end
end
