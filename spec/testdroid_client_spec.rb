require 'spec_helper'

describe Testdroid::Cloud::Client do
  it "should have a API_VERSION constant" do
	client = Testdroid::Cloud::Client.new('username', 'password')
	client.instance_variable_get('@username').should == 'username'
  end
end
