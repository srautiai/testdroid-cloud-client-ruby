
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
				return nil unless File.exist?(filename)
				Digest::MD5.hexdigest(File.read(filename))
				@client.post "/projects/#{id}/apks/application",  {:file => File.new(filename), :multipart => true,  }, {:'X-Testdroid-MD5' => digest}
			end
		end
	end
end
