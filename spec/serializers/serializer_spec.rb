require 'spec_helper'

describe "Metadata" do
  it "should be included for spec/serializers" do
    example.metadata[:type].should == :serializer
  end
end
