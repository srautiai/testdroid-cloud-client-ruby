#!/usr/bin/ruby

#require './testdroid_cloud/version.rb'
require 'json'
require 'rest_client'

require './testdroid_client.rb'
require './cloud_resource.rb'
require './cloud_list_resource.rb'
require './projects/projects.rb'
require './user.rb'

if __FILE__ == $0    
	begin
		cloud = Testdroid::Cloud::Client.new('sakari.rautiainen@bitbar.com', 'abcde')
		#cloud.authorize
		user =  cloud.get_user
		#puts "user methods"
		#puts user.methods.sort
		#puts "user all"
		projects = user.projects()
		puts projects.get(1070071).name
		puts "end"
	end
end
