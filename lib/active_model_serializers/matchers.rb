module ActiveModel
  module Serializers
    module Matchers
      class Root
        attr_accessor :name, :actual

        def initialize(name = true)
          @name = name
        end

        def matches?(actual)
          @actual = actual

          serializer._root == name
        end

        def description
          "have attribute #{name}"
        end

        def failure_message_for_should
          %Q{expected "#{actual._root}" to be "#{name}", but it wasn't}
        end

        def failure_message_for_should_not
          %Q{expected "#{actual._root}" to be "#{name}", but it was}
        end

        private
        def serializer
          if actual.is_a?(Class)
            actual
          else
            actual.class
          end
        end
      end

      def include_root(key = nil)
        Root.new key
      end

      class Embed
        attr_accessor :expected, :actual

        def initialize(expected)
          @expected = expected
        end

        def matches?(actual)
          @actual = actual

          serializer._embed == expected
        end

        def description
          "embed #{name}"
        end

        def failure_message_for_should
          %Q{expected "#{actual._embed}" to be "#{name}", but it wasn't}
        end

        def failure_message_for_should_not
          %Q{expected "#{actual._embed}" to be "#{name}", but it was}
        end

        private
        def serializer
          if actual.is_a?(Class)
            actual
          else
            actual.class
          end
        end
      end

      def embed(value)
        Embed.new value
      end

      class HaveAttribute
        attr_accessor :name, :actual

        def initialize(name)
          @name = name
        end

        def matches?(actual)
          @actual = actual

          attributes.has_key?(name)
        end

        def description
          "have attribute #{name}"
        end

        def failure_message_for_should
          %Q{expected #{actual.inspect} to include "#{name}", but it did not}
        end

        def failure_message_for_should_not
          %Q{expected #{actual.inspect} to not include: "#{name}", but it did}
        end

        private
        def serializer
          if actual.is_a?(Class)
            actual
          else
            actual.class
          end
        end

        def attributes
          serializer._attributes
        end
      end

      def have_attribute(name)
        HaveAttribute.new name
      end

      class AssociationMatcher
        attr_accessor :name, :actual, :key

        def initialize(name)
          @name = name
        end

        def matches?(actual)
          @actual = actual

          matched_association = associations.select do |assc|
            assc.name == name
          end.first

          return false unless matched_association

          if key
            return false if matched_association.key != key
          end

          true
        end

        def as(value)
          self.key = value
          self
        end

        def description
          "have attribute #{name}"
        end

        def failure_message_for_should
          %Q{expected #{actual.inspect} to include a "#{name}" association, but it did not}
        end

        def failure_message_for_should_not
          %Q{expected #{actual.inspect} to not include a "#{name}" association, but it did}
        end

        private
        def serializer
          if actual.is_a?(Class)
            actual
          else
            actual.class
          end
        end

        def associations
          serializer._associations
        end
      end

      def have_many(name)
        AssociationMatcher.new(name)
      end
      alias :have_one :have_many
    end
  end
end
