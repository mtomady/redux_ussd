# Redux USSD

[![Coverage Status](https://coveralls.io/repos/github/mtomady/redux_ussd/badge.svg?branch=master)](https://coveralls.io/github/mtomady/redux_ussd?branch=master) [![Build Status](https://travis-ci.org/mtomady/redux_ussd.svg?branch=master)](https://travis-ci.org/mtomady/redux_ussd)


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
  include ReduxUssd 
  
  menu do
    screen :index do
      after do
        push :welcome unless session[:user].nil? 
      end
    end
    
    screen :welcome do
        text "Welcome #{session[:user].name}"
        option :balance, text: 'Show current balance'
        option :transfer, text: 'Transfer money'  if session[:user].can_transfer_money?
        
        after do |state|
            push state[:options][:option]
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
  
  # Fetch the state from a persistence object like ActiveRecord and 
  # setup the menu
  def initialize(session)
    @session = session
    menu.setup_menu(@session.state)
  end
  
  # Save the state back to persistence object
  def save_state
    @session.update(state: menu.state)
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DoctorsForMadagascar/redux_ussd. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the reduxUssd project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/DoctorsForMadagascar/redux_ussd/blob/master/CODE_OF_CONDUCT.md).
