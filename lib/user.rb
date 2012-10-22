module Testdroid
	module Cloud
		
		class User < CloudResource
			def initialize(uri, client, params={})
			super uri, client, params
			sub_items :projects
		  end
		end
  end
end
