
module Testdroid
	module Cloud
		class CloudResource
			def initialize(uri, client,  resource_name, params= {})
			 @uri, @client, @resource_name = uri, client, resource_name
			 set_up_properties_from( params )
			end
			def inspect # :nodoc:
				"<#{self.class} @uri=#{@uri}>"
			end
			def sub_items(*items)
				items.each do |item|
				  resource = twilify item
				  #relative_uri = r == :sms ? 'SMS' : resource
				  puts "#{resource} - item: #{item}"
				  uri = "#{@uri}/#{item}"
				  resource_class = Testdroid::Cloud.const_get resource
				  instance_variable_set( "@#{item}", resource_class.new(uri, @client) )
				  puts "Projects : #{@projects} - resource_class #{resource_class}"
				  
          
				end
			end
			def method_missing(method, *args)
				puts "Logging:#{method} - #{args}"
				super if @updated
				
				puts "Never here?"	
				set_up_properties_from(@client.get(@uri,@resource_name))
				self.send method, *args
			end
			def set_up_properties_from(hash)
				puts "Hash:#{hash}"
				eigenclass = class << self; self; end
				hash.each do |p,v|
				  property = detwilify p
				  unless ['uri', 'client', 'updated'].include? property
					eigenclass.send :define_method, property.to_sym, &lambda {v}
				  end
				end
				@updated = !hash.keys.empty?
			  end
			# Refresh the attributes of this instance resource object by fetching it
			# from Twilio. Calling this makes an HTTP GET request to <tt>@uri</tt>.
			def refresh
				raise "Can't refresh a resource without a REST Client" unless @client
				@updated = false
				set_up_properties_from(@client.get(@uri))
				self
			end
			 
			 def twilify(something)
				if something.is_a? Hash
				  Hash[*something.to_a.map {|a| [twilify(a[0]).to_sym, a[1]]}.flatten]
				else
				  something.to_s.split('_').map do |s|
					[s[0,1].capitalize, s[1..-1]].join
				  end.join
				end
			  end
			 def detwilify(something)
				if something.is_a? Hash
					Hash[*something.to_a.map {|pair| [detwilify(pair[0]).to_sym, pair[1]]}.flatten]
				else
					something.to_s.gsub(/[A-Z][a-z]*/) {|s| "_#{s.downcase}"}.gsub(/^_/, '')
				end
			end
		end
	end
end
