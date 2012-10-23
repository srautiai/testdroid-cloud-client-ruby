
module Testdroid
	module Cloud
		class Projects < CloudListResource
		end
		class Project < CloudResource
		
			def	initialize(uri, client, params= {})
				
				super uri, client,"project", params
				
				#puts "init called #{uri}-#{client}- #{params}"
				@uri, @client = uri, client
				sub_items :config, :runs
			end
			def runs
				
				@runs
			end
			
			def config
				#puts "#{@config}"
				#p @config
				@config
			end
			def run(instatest=true)
				#puts "local"
				#puts self
				#p "/projects/#{@id}/run - #{id}"
				@client.post("/projects/#{id}/run", "project/run/#{id}", {instatestMode:true})
			end
		end
	end
end
