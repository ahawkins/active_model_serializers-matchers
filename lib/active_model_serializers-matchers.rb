require 'active_model_serializers'

module ActiveModel::Serializers::Matchers
end

require "active_model_serializers/matchers/version"
require "active_model_serializers/matchers"

module SerializerExampleGroup
  extend ActiveSupport::Concern
  include ActiveModel::Serializers::Matchers

  included do
    subject { described_class }

    metadata[:type] = :serializer
  end
end

require 'rspec'

RSpec.configure do |config|
  config.include SerializerExampleGroup, :example_group => {
    :file_path => /spec\/serializers/
  }
end
