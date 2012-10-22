module Testdroid
	module Cloud
		
		class User < CloudResource
			def initialize(uri, client, params={})
				super uri, client, params
				
				sub_items :projects
			end
			def projects()
				puts "Getting projects"
				#@projects.list()
				#puts "#{@Aprojects}"
				#p @Aprojects
				#puts "#{@Aprojects.instance_methods()}"
				@projects
			end
		end
  end
end
