require 'spec_helper'
require 'testdroid-cloud'

describe Testdroid::Cloud::DeviceRuns do
  it 'should set up runs resources object' do
    deviceruns = Testdroid::Cloud::DeviceRuns.new('/projects/132/runs/12312/', 'tClient')
    deviceruns.instance_variable_get('@uri').should == '/projects/132/runs/12312/'
  end
end
