
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
			def run(cluster_id= nil, instatest=true, device_ids=nil)
				if(cluster_id && device_ids)
					raise "Set only clusterId or device ids"
				end
				resp = @client.post("/projects/#{id}/run", "project/run/#{id}", {instatestMode:instatest, usedClusterId:cluster_id, usedDeviceIds:device_ids})
				Testdroid::Cloud::Run.new("api/v1/projects/#{id}/runs/#{resp['id']}", @client, resp)
			end
			def uploadAPK(filename)
				if !File.exist?(filename) 
					@client.logger.error( "Invalid filename")
					return
				end
				@client.upload("/projects/#{id}/apks/application",id, filename) 
			end
		end
	end
end
