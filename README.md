# Redux USSD

[![Coverage Status](https://coveralls.io/repos/github/DoctorsForMadagascar/redux_ussd/badge.svg?branch=master)](https://coveralls.io/github/DoctorsForMadagascar/redux_ussd?branch=master) [![Build Status](https://travis-ci.org/DoctorsForMadagascar/redux_ussd.svg?branch=master)](https://travis-ci.org/DoctorsForMadagascar/redux_ussd)


Redux USSD provides an easy DSL to built [USSD](https://en.wikipedia.org/wiki/Unstructured_Supplementary_Service_Data) user interfaces on features phones. It uses the Redux pattern to handle states and perform actions. This library also provides a persistence extension to save state in Redis, ActiveRecord etc.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redux_ussd'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redux_ussd

## Usage

Extend an existing class or module
```ruby
class HelloWorldMenu
  include Redux::Ussd 
  
  ussd do
    screen :index, initial: true do
      after do
        push :welcome unless session[:user].nil? 
      end
    end
    
    screen :welcome do
        text "Welcome #{session[:user].name}"
        option :balance, text: 'Show current balance'
        option :transfer, text: 'Transfer money'
        
        after do |new_state|
          logger.info("New screen: #{new_state[:navigation][:screen]}")
        end
    end
    
    screen :balance do
      text "Your current balance is #{session[:user].balance}"
    end
    
    screen :transfer do
      prompt :amount, 'How much?'
      
      after do |state|
        session[:user].tranfer_amount(state[:prompt][:values][:amount])
        push :welcome
      end
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/redux_ussd. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the reduxUssd project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/redux_ussd/blob/master/CODE_OF_CONDUCT.md).
