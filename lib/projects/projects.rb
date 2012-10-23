
module Testdroid
	module Cloud
		class Projects < CloudListResource
		end
		class Project < CloudResource
		
			def	initialize(uri, client, params= {})
				super uri, client,"project", params
				@uri, @client = uri, client
				sub_items :config, :runs
			end
			def run(instatest=true)
				@client.post("/projects/#{id}/run", "project/run/#{id}", {instatestMode:true})
			end
		end
	end
end
