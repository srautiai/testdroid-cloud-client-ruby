require 'spec_helper'
require 'testdroid-cloud'

describe Testdroid::Cloud::Project do
  it 'should set up runs resources object' do
    project = Testdroid::Cloud::Project.new('cloudUri', 'tClient')
    project.respond_to?(:runs).should == true
    project.runs.instance_variable_get('@uri').should == 'cloudUri/runs'
  end
end
