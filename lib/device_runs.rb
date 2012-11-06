
module Testdroid
	module Cloud
		class DeviceRuns < CloudListResource
		end
		class DeviceRun < CloudResource
			def	initialize(uri, client, params= {})
				super uri, client,"deviceRun", params
				@uri, @client = uri, client
			end
      def download_scrshots_zip(file_name="screenshots.zip")
        @client.download(screenshots_u_r_i, "screenshots.zip", file_name)
      end
      def download_junit(file_name="junit.xml")
        @client.download(junit_u_r_i, "junit XML", file_name)
      end
      def download_logcat(file_name="logcat.txt")
        @client.download(log_u_r_i, "log", file_name)
      end
		end
	end
end
