
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
				resp = @client.post("/projects/#{id}/run", "project/run/#{id}", {instatestMode:instatest})
				Testdroid::Cloud::Run.new("/projects/#{id}/runs/#{resp['id']}", @client, resp)
			end
			def uploadAPK(filename)
				if !File.exist?(filename) 
					$stderr.puts "Invalid filename"
					return
				end
				@client.upload("/projects/#{id}/apks/application",id, filename) 
			end
		end
	end
end
