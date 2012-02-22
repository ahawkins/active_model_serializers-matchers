# ActiveModelSerializer::Matchers

RSpec Matchers for testing ActiveModel::Serializers

This gem currently works with the **0.1.0** release. It will be updated
for the next public release when that happens.

## Installation

Add this line to your application's Gemfile:

    gem 'active_model_serializer-matchers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_model_serializer-matchers

## Usage

Matchers are automatically included in all specs in `spec/serializers`.

Here are some examples

```ruby
describe BlogPostSerializer do
   it { should have_attribute(:title) }
   it { should have_attribute(:text) }

   it { should have_one(:author) }

   it { should have_many(:comments) }
   it { should have_many(:comments).as(:responses) }

   it { should embed(:objects) }

   it { should include_root }

   it { should include_root(:blog_post) } # if you want to test the root is specifically set to a different value
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
