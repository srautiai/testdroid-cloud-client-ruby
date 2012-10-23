require 'spec_helper'


describe Testdroid::Cloud::Run do
  it 'should set up device runs resources object' do
    run = Testdroid::Cloud::Run.new('cloudUri', 'tClient')
    run.respond_to?(:device_runs).should == true
    run.instance_variable_get('@uri').should == 'cloudUri'
  end
end
