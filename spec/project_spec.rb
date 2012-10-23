require 'spec_helper'
require 'testdroid-cloud'

describe Testdroid::Cloud::Project do
  it 'should set up runs resources object' do
    project = Testdroid::Cloud::Project.new('cloudUri', 'tClient')
    project.respond_to?(:runs).should == true
    project.runs.instance_variable_get('@uri').should == 'cloudUri/runs'
  end
  it 'should return run after running project' do
    connection = double(:post => JSON.parse('{"id":101676, "groupState":"FINISHED", "displayName":"Test Run 7"}'), :get => { "id" => 82})
    
    project = Testdroid::Cloud::Project.new('someurl', connection)
    run = project.run()
    puts run.id
    
  end
end
