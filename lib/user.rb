module Testdroid
	module Cloud
		
		class User < CloudResource
			def initialize(uri, client, params={})
				super uri, client,"users", params
				
				sub_items :projects
			end
		end
  end
end
