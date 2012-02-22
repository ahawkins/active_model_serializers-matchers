require 'spec_helper'

describe ActiveModel::Serializers::Matchers do
  include ActiveModel::Serializers::Matchers

  it "should be false if the serializer does not have an attribute" do
    serializer = Class.new ActiveModel::Serializer do
      attributes :foo
    end

    serializer.should_not have_attribute :bar
    serializer.should have_attribute :foo
  end

  it "should match the embed setting" do
    serializer = Class.new ActiveModel::Serializer do
      embed :ids
    end

    serializer.should embed(:ids)
    serializer.should_not embed(:objects)
  end

  describe "The root key" do
    it "should match the root setting" do
      serializer = Class.new ActiveModel::Serializer do

      end

      serializer.should include_root
    end

    it "should be able to match a specific key" do
      serializer = Class.new ActiveModel::Serializer do
        root :foo
      end

      serializer.should include_root(:foo)
      serializer.should_not include_root(:bar)
    end
  end

  describe "Associations" do
    it "should work with has_many" do
      serializer = Class.new ActiveModel::Serializer do
        has_many :foos
      end

      serializer.should have_many(:foos)
      serializer.should_not have_many(:bars)
    end

    it "should work with has_one" do
      serializer = Class.new ActiveModel::Serializer do
        has_one :foo
      end

      serializer.should have_one(:foo)
      serializer.should_not have_one(:bar)
    end

    it "should work with has_one key options" do
      serializer = Class.new ActiveModel::Serializer do
        has_one :foo, :key => :bar
      end

      serializer.should have_one(:foo).as(:bar)
      serializer.should have_one(:foo)
      serializer.should_not have_one(:foo).as(:qux)
    end

    it "should work with has_many key options" do
      serializer = Class.new ActiveModel::Serializer do
        has_one :foos, :key => :bars
      end

      serializer.should have_one(:foos).as(:bars)
      serializer.should have_one(:foos)
      serializer.should_not have_one(:foos).as(:qux)
    end
  end
end
