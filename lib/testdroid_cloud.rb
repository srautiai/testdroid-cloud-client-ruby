#!/usr/bin/ruby

#require './testdroid_cloud/version.rb'
require 'json'
require 'rest_client'

require 'testdroid_client'
require 'cloud_resource'
require 'cloud_list_resource'
require 'projects/projects'
require 'user'
require 'config'
require 'test_run'

if __FILE__ == $0    
	begin
		cloud = Testdroid::Cloud::Client.new('admin@localhost', 'abcde', 'http://82.181.200.141:9080/testdroid-cloud', 'http://82.181.200.141:9080/testdroid-usermanagement')
		#cloud.authorize
		user =  cloud.get_user
		#puts "user methods"
		#puts user.methods.sort
		#puts "user all"
		projects = user.projects()
		#puts projects.get(101650).name
		#puts projects.get(101650).config
		#puts "Test Run--------"
		#p projects.get(101650).runs.list()
		puts projects.get(101650).runs.get(101674).group_state
		puts "end"
	end
end
